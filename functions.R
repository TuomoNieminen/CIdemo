compute_ci <- function(sample, n, type ="z", p = 0.05, truevalue=2) {
  mu_hat <- mean(sample)
  se <- sd(sample)/sqrt(n)
  
  if(type=="z") {
    error_margin <- qnorm(p=1-p/2)*se
  }
  if(type=="t") {
    error_margin <- qt(df = n-1, p = 1-p/2)*se
  }
  
  return(c(true = truevalue,
           est. = mu_hat,
           se. = se,
           low95 = mu_hat - error_margin,
           up95 = mu_hat + error_margin))
}

contains_true <- function(truevalue, CI) {
  contains <- function(low, up, real=truevalue) {
    (real >= low & real <= up)
  }
  mapply(contains, CI[1,], CI[2,])
}

get_playGround <- function(i, rtext="write any (R) code here") {
  div(class="intro-playground",
      
      h4("R playground"),br(),
      
      # code input
      div(tags$textarea(id=paste0("code",i),
                        rows=5, cols=90,
                        paste("#",rtext," \n \n"))),
      
      # code type choice, execution btn, feedback
      
      fluidRow(
        column(2,          
               # code execution
               actionButton(paste0("execute",i),"Go!")
        ),
        column(4,
               # code type
               radioButtons(paste0("codetype",i),
                            label = "Choose output type",
                            choices = list("basic" = "text",
                                           "plot" = "plot"),
                            selected = "text")
        ),
        
        column(6,
               br(),
               htmlOutput(paste0("feedback",i))
        )
      ),
      
      # output
      
      conditionalPanel(
        condition=paste0("input.codetype",i,"=='text'"),
        verbatimTextOutput(paste0("text",i))
      ),
      conditionalPanel(
        condition=paste0("input.codetype",i,"=='plot'"),
        plotOutput(paste0("plot",i),width="60%",height="250px")
      )
      
  )
}


add.alpha <- function(someColor, a=0.5)
{
  alpha = a*225
  newColor<-col2rgb(someColor)
  apply(newColor, 2, function(curcoldata){rgb(red=curcoldata[1], green=curcoldata[2],
                                              blue=curcoldata[3],alpha=alpha, maxColorValue=255)})
}
