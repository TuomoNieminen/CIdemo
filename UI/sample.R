div(class="ci-tab-panel",
    
    br(),
    h3("Sample", align="center"),
    br(),
    p("In this tutorial we'll experiment with confidence intervals. 
      To start things off we'll need some samples. Start by choosing a sample size, a mean and a standard deviation."),
    fluidRow(
      column(3,
    numericInput("n", label = "Number of samples",
                 min=2, max=30, value = 20)),
    column(3,
           numericInput("mean", label="mean", value=2)),
    column(3,
           sliderInput("sd",label="standard deviation", value=2,min=1, max=50))
),
checkboxInput("show_theoretical", label="Show the theoretical distribution"),
br(),
conditionalPanel(condition="input.show_theoretical",
                 plotOutput("theoretical",width="70%")
),
    
    p("Your choice prompts the following R code:"),
    pre("my_sample <- rnorm(n=input$n, mean=input$mean, sd=input$sd)"),
    
    p("which draws samples from the normal distribution. 
           You can inspect your sample by clicking on 'Show samples' below."),
    
    checkboxInput("show_samples", label="Show samples"),
    br(),
    conditionalPanel(condition="input.show_samples",
                     
                     p("You can control how many values of your sample you wish to see 
                            and the (approximate) number of breaks in the histrogram of the sample."),
                     
                     fluidRow(
                       column(4,
                              htmlOutput("howmany_values"),
                              tableOutput("sample_table")),
                       
                       column(8,
                              sliderInput("breaks",label="Approximate number of breaks",
                                          value=7, min=1, max=20),
                              plotOutput("sample_plot")
                       ))
    ),
    br(),
    
    p("Next, we'll use two techniques to compute a 95% confidence interval for the estimate of the population mean. 
           How would you do it? Try to come up with a formula for the estimate and a confidence interval. 
           A 95% confidence interval is an interval that on average contains the true 
           parameter value 95% of the time."),
    p("Experiment with R below. You have access to the object `my_sample`."),
    
    # R playground
    
    get_playGround(1,"`my_sample` is available")
    
)