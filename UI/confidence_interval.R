div(class="ci-tab-panel",

    h3("Interval estimates for the mean", align="center"),

    p("Next we'll estimate the population mean and then use two techniques 
        for computing a confidence interval for our estimate. 
        A 95% confidence interval makes a promise that such intervals calculated 
      from future samples have a 95% probability of containing the true parameter value."),

        p("The sample mean can be used to estimate the population mean. 
        For the confidence interval, we'll also need the standard deviation."),
    pre("estimate <- mean(my_sample)
se <- sd(my_sample)/sqrt(input_n)"),
    
    checkboxInput("show_ci", label="Show confidence intervals"),
    br(),
    conditionalPanel(condition="input.show_ci",
                     
                     fluidRow(
                       column(6,
                              h4("z-method"),
                              pre("z_critical <- qnorm(p=0.975)
z_error_margin <- z_critical*se
z_lower95 <- estimate - z_error_margin
z_upper95 <- estimate + z_error_margin"),
                              br(),
                              p("The z-method assumes that we know the population standard deviation, 
or that the sample standard deviation perfectly corresponds to the population standard deviation. 
                                     The latter is of course unrealistic with small sample sizes."),
                              br(),
                              tableOutput("z_ci")),
                       
                       column(6,
                              h4("t-method"),
                              pre("t_critical <- qt(df=input$n-1, p = 0.975)
t_error_margin <- t_critical*se
t_lower95 <- estimate - t_error_margin
t_upper95 <- estimate + t_error_margin"),
                              br(),
                              p("The t-method treats the sample standard deviation as 
an unknown random variable (which it usually is). 
                                It takes into account the added uncertainty."),
                              br(),br(),
                              tableOutput("t_ci"))
                     )
    ),
    
    br(),
    
    h3("Up next"),
    p("The promise of the confidence interval is that if we could take more samples, 
then future similarily calculated intervals would contain the true parameter value 95% of the time. 
      Now that we know our true parameter value (we chose it for sampling), 
      we should be able to somehow test how often our intervals actually contain it. 
     Can you think of a way to test if the promise of the confidence intervals holds?"), 
      p("You can again experiment with R below."),
    hr(),
    
    # R playground
    
    get_playGround(2, "my_sample is available")
    
)
