
shinyServer(function(input, output, session) {
  
  source("functions.R", local=T)$value
  
  # navigation
  
  nav <- reactiveValues(val=1)
  observe({
    nav$val <- as.numeric(input$nav)
  })
  
  observeEvent(input$cont, {
    nav$val <- min(chapters, as.numeric(input$nav) + 1)
  })
  
  observeEvent(input$prev, {
    nav$val <-  max(1,as.numeric(input$nav) - 1)
  })
  
  observe({
    updateTabsetPanel(session, inputId="nav", 
                      selected = paste(nav$val))
  })
  # parameters and single sample statistics
  
  d <- reactiveValues(sample=NULL)
  observe({
    d$mu <- input$mean
    d$sd <- input$sd
    d$n <- ifelse(is.na(input$n), 2, input$n)
    d$n <- abs(d$n)
    d$sample <- rnorm(d$n, mean=d$mu, sd=d$sd)
    d$z <- compute_ci(d$sample, d$n, type="z", truevalue = d$mu)
    d$t <- compute_ci(d$sample, d$n, type="t", truevalue = d$mu)
  })
  
  # plot of the theoretical distribution
  
  output$theoretical <- renderPlot({
    from <- d$mu - 4*d$sd
    to <- d$mu + 4*d$sd
    curve(dnorm(x, d$mu, d$sd), 
          from= from, to = to,
          ylab="density", ylim=c(0,0.4))
    x <- seq(from, to, 0.01)
    x.cord <- c(from, x, to)
    y.cord <- c(0, dnorm(x,d$mu, d$sd), 0)
    polygon(x.cord, y.cord, col="grey92")
  })
  
  
  # show the samples and confidence interval for the population mean estimate
  
  output$howmany_values <- renderUI({
    sliderInput("howmany_values",label="How many values to show?",
                min=1,max=d$n, value=4, step=1)
  })
  
  output$sample_table <- renderTable({
    n <- input$howmany_values
    n <- ifelse(is.null(n),4, n)
    head(data.frame(value = d$sample), n = n)
  })
  output$sample_plot <- renderPlot({
    hist(d$sample,breaks=input$breaks)
  })
  
  # confidence interval tables
  
  output$z_ci <- renderTable({
    t(data.frame(mu = d$z))
  })
  output$t_ci <- renderTable({
    t(data.frame(mu=d$t))
  })
  
  # draw more samples and compute more confidence intervals
  
  observe({
    d$N <- input$N
    d$more_samples <- sapply(1:d$N, function(i) rnorm(d$n, d$mu, d$sd))
    d$z_CI <- apply(d$more_samples, 2, compute_ci, n=d$n, type="z", truevalue=d$mu)
    d$t_CI <- apply(d$more_samples, 2, compute_ci, n=d$n ,type="t", truevalue=d$mu)
    
    d$zCI <- data.frame(round(t(d$z_CI),2))
    d$tCI <- data.frame(round(t(d$t_CI),2))
    
    d$z_contains_true <- contains_true(d$mu, d$z_CI[4:5,])
    d$z_prc_inside <- round(100*sum(d$z_contains_true)/d$N,1)
    
    d$t_contains_true <- contains_true(d$mu, d$t_CI[4:5,])
    d$t_prc_inside <- round(100*sum(d$t_contains_true)/d$N,1)
    
  })
  
  # output$howmany_samples <- renderUI({
  #   sliderInput("howmany_samples", "How many samples to show?", 
  #               min=1, max=input$N, value=6, step=1)
  # })
  
  output$z_more_samples <- DT::renderDataTable({
    DT::datatable(d$zCI,
                  options=list(searching=FALSE))
  })
  
  output$t_more_samples <- DT::renderDataTable({
    DT::datatable(d$tCI,
                  options=list(searching=FALSE))
  })
  
  
  output$z_mu_info <- renderText({
    paste("In this case", d$z_prc_inside, "% of the 95% z confidence intervals contained the actual parameter value.")
  })
  output$t_mu_info <- renderText({
    paste("In this case", d$t_prc_inside, "% of the 95% t confidence intervals contained the actual parameter value.")
  })
  
  output$howmany_zci <- renderUI({
    sliderInput("howmany_zci", "how many confidence intervals to plot?",
                min = 2, max = d$N, step = 2, value = 10)
  })
  output$howmany_tci <- renderUI({
    sliderInput("howmany_tci", "how many confidence intervals to plot?",
                min = 2, max = d$N, step = 2, value = 10)
  })
  
  
  output$z_mu_plot <- renderPlot({
    N <- input$howmany_zci
    N <- ifelse(is.null(N),10,N)
    col = c("red","grey10")[d$z_contains_true+1][1:N]
    CI <- d$z_CI[,1:N]
    plotrix::plotCI(x=1:N, y=CI[2,], 
           li = CI[4,], ui = CI[5,],
           pch=NA, col = col)
    abline(h=CI[1,1],col="green")
    
  })
  output$t_mu_plot <- renderPlot({
    N <- input$howmany_tci
    N <- ifelse(is.null(N),10,N)
    col = c("red","grey10")[d$t_contains_true+1][1:N]
    CI <- d$t_CI[,1:N]
    plotrix::plotCI(x=1:N, y=CI[2,], 
           li = CI[4,], ui = CI[5,],
           pch=NA, col = col)
    abline(h=CI[1,1],col="green")
    
  })
  
  # user code input execution
  
  envs <- lapply(1:chapters,new.env)
  
  codeInput <- lapply(1:chapters,function(i) {
    reactive({
      tryCatch(parse(text=input[[paste0("code",i)]]),
               error=function(e) NULL)
    })
  })
  
  lapply(1:chapters,function(i) {
    observeEvent(input[[paste0("execute",i)]], {
      
      type <- isolate(input[[paste0("codetype",i)]])
      code <- isolate(codeInput[[i]]())
      
      env <- envs[[i]]
      env$input_n <- d$n
      env$input_mean <- d$mu
      env$input_sd <- d$sd
      env$my_sample <- d$sample
      if(nav$val>1) {
        env$input_N <- d$N
        env$more_samples <- data.frame(d$more_samples)
      }
      if(nav$val==3) {
        env$zCI <- d$zCI
        env$tCI <- d$tCI
      }
      
      output[[paste0(type,nav$val)]] <- switch(type,
                                               "plot" =  renderPlot({eval(code,
                                                                          envir=env)}),
                                               "text" =  renderPrint({eval(code,
                                                                           envir=env)})
      )
      
    })
  })
  
})
