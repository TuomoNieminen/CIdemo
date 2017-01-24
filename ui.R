

library(shiny)

shinyUI(fluidPage(
  includeCSS("style.css"),
  
  tabsetPanel(id="nav", #widths=c(2,10),
              tabPanel("sample",value=1,
                       source("UI/sample.R", local=T)$value
              ),
              tabPanel("confidence interval", value=2,
                       source("UI/confidence_interval.R", local=T)$value
                    ),
              tabPanel("more_intervals", value=3,
                       source("UI/more_intervals.R", local=T)$value
              ),
              tabPanel("results", value=4,
                       source("UI/results.R", local=T)$value
              )
  ),
  br(),
  
  # navigation 
  
  fluidRow(
    column(3),
    column(3,
           actionButton(inputId="prev",label=" Previous",
                        icon=icon("arrow-circle-left "))),
    column(3,
           actionButton(inputId="cont",label=" Continue",
                        icon=icon("arrow-circle-right "))),
    column(3)
  ),
  br(),br()
  
))
