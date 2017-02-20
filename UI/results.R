div(class="ci-tab-panel",

    h3("Results of the experiment", align="center"),
    
    p("The confidence intervals calculated from repeated sampling 
are based on a promise that they contain the true parameter value a (chosen) high 
      percentage of the time. The following R code can be used to check if an interval contains a value:"),
    
    pre("input_mean >= ci_lower | input_mean <= ci_upper"),

p("Click to see how often our two different 
      intervals actually contain the true parameter value."),
    
    checkboxInput("show_results_z", label="Show results for z"),
    conditionalPanel(condition="input.show_results_z",
                     h4("Results for the z confidence intervals"),
                     br(),
                     textOutput("z_mu_info"),
                     br(),
                     htmlOutput("howmany_zci"),
                     plotOutput("z_mu_plot")),
    
    checkboxInput("show_results_t", label="Show results for t"),
    conditionalPanel(condition="input.show_results_t",
                     
                     h4("Results for the t confidence intervals"),
                     br(),
                     textOutput("t_mu_info"),
                     br(),
                     htmlOutput("howmany_tci"),
                     plotOutput("t_mu_plot")),
    
h3("Conclusions"),
    p("In this case we used a sample estimate for the standard deviation 
when calculating the z confidence interval. 
The z interval assumes knowledge of the population standard deviation so 
it is now over confident (too narrow) and should contain the true parameter 
value a little less than 95% of the time. However if you chose a reasonably large sample size, 
then the difference between the z and t intervals should be small 
      and they should both deliver their promise well."),

p("In practise it is unlikely to find a situation where you would know the population standard 
  deviation but not the mean. Therefore it is unlikely that you would want to use a z interval. 
  A t interval is a good choice whenever the sampling ditribution of the parameter of 
  interest is approximately normal. This is the case whenever the sample size is reasonably large, 
  and it is also always the case if the underlying population distribution is normal."),
hr(),

    get_playGround(4,"my_sample, more_samples, zCI and tCI are available")
    
    )
