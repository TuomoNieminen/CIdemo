div(class="ci-tab-panel",
    br(),
    h3("Results of the experiment"),
    br(),
    p("The confidence intervals are based on a promise that on average 
      the interval contains the true parameter value a (chosen) high 
      percentage of the time."),
    
    p("The following R code can be used to check if an interval contains a value:"),
    pre("input$mean >= ci_lower | input$mean <= ci_upper"),

p("Click to see how often our two different 
      intervals actually contain the true parameter value."),
    
    checkboxInput("show_results_z", label="Show results for z"),
    conditionalPanel(condition="input.show_results_z",
                     h4("Results for the z confidence intervals"),
                     
                     textOutput("z_mu_info"),
                     br(),
                     htmlOutput("howmany_zci"),
                     plotOutput("z_mu_plot")),
    
    checkboxInput("show_results_t", label="Show results for t"),
    conditionalPanel(condition="input.show_results_t",
                     
                     h4("Results for the t confidence intervals"),
                     
                     textOutput("t_mu_info"),
                     br(),
                     htmlOutput("howmany_tci"),
                     plotOutput("t_mu_plot")),
    
    p(""),
    
    get_playGround(4,"my_sample, more_samples, zCI and tCI are available")
    
    )