div(class="ci-tab-panel",
    br(),
    h3("More intervals", align="center"),
    br(),
    
    p("Next, we'll test if our confidence intervals deliver what they have promised by 
      taking more samples and computing more confidence intervals."),
    p("We'll draw more samples from the same distribution."),
    br(),
    
    numericInput("N",label="How many times do you wish to repeat the sampling?",
                 min = 1,value = 1000, step = 10),
    p("Your choice prompts the following R code:"),
    pre("more_samples <- sapply(1:input$N, function(i) rnorm(input$n, input$mean, input$sd))"),
    
    checkboxInput("more_intervals", label="Show more confidence intervals"),
    
    conditionalPanel(condition="input.more_intervals",
                     
                     p("Below are the estimates (sample means) and confidence intervals 
                       for each of the samples. The tables are interactive 
                       and sortable."),
                     br(),
                     
                     #htmlOutput("howmany_samples"),
                     fluidRow(
                       column(6,
                              div(class="ci-z", style="padding:20px;",
                                  h4("z confidence intervals"),
                                  br(),
                                  DT::dataTableOutput("z_more_samples"))
                       ),
                       column(6,
                              div(class="ci-t", style="padding:20px;",
                                  h4("t confidence intervals"),
                                  br(),
                                  DT::dataTableOutput("t_more_samples"))
                       ))
    ),
    br(),
    
    p("Okey so now we have a bunch of confidence intervals computed using the z and t techniques. 
      Now we should be able to see what percentage of them actually contains the true 
      parameter value."),
    
    p("Can you think of a way to check if a single confidence interval contains the true parameter value? 
      You'll need the logical operators in R."),
    # R playground
    
    get_playGround(3, "my_sample, more_samples, zCI and tCI are available")
    
)