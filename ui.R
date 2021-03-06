

library(shiny)

shinyUI(fluidPage(
  includeCSS("www/style.css"),
  
  fluidPage(
    list(tags$head(HTML('<link rel="icon", href="MyIcon.png", 
                        type="image/png" />'))),
    div(style="padding: 1px 0px; width: '100%'",
        titlePanel(
          title="", windowTitle="CI demo"
        )
    )),
        
        # wrapper
        div(class = "wrapper",
      
      navbarPage(title = div(tags$a(img(id ="github", src = 'github.png'), 
                                    href = "https://github.com/TuomoNieminen/CIdemo"), 
                 " CI demo"), 
                 id="nav", position = "fixed-top",
                 
                 tabPanel("A Random Sample",value=1,
                          source("UI/sample.R", local=T)$value),
                 tabPanel("Confidence Interval", value=2,
                          source("UI/confidence_interval.R", local=T)$value),
                 tabPanel("More Intervals", value=3,
                          source("UI/more_intervals.R", local=T)$value),
                 tabPanel("Results", value=4,
                          source("UI/results.R", local=T)$value)
      ),
      br()
  ),
  
  hr(),
  div(align = "center", "Tuomo Nieminen 2016"),br()
  
))
