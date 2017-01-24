div(class="ci-tab-panel",
    
    br(),
    h3("Sample", align="center"),
    br(),
    p("In this tutorial we'll experiment with confidence intervals. 
      To start things off we'll need some samples. Start by choosing a sample size, a mean and a standard deviation."),
    br(),
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
    pre("my_sample <- rnorm(n=input_n, mean=input_mean, sd=input_sd)"),
    
    p("which draws samples from the normal distribution."),
br(),
    
    checkboxInput("show_samples", label="Show samples"),
    br(),
    conditionalPanel(condition="input.show_samples",
                     
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
    
    p("Next, we'll use two techniques to compute 
a 95% confidence interval for the estimate of the population mean. 
A confidence interval is based on the idea that the sample we observe is random 
      and thus any estimate calculated from it will vary from sample to sample. 
      A 95% confidence interval is an interval which 
      would include the true parameter value 95% of the time if the sampling were repeated."),
    p("How would you calculate it? Try to come up with a formula for the estimate and a confidence interval. 
      You can experiment with R below. You have access to the object `my_sample`."),
hr(),
    
    # R playground
    
        get_playGround(1,"my_sample is available")
    
)
