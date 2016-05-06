# CIdemo
Interactive demonstration of confidence intervals

R Shiny interactive demonstration of frequentistic confidence intervals.

Shiny is an R library for creating interactive web applications. This  app allows the user explore frequentistic confidence intervals. 
A unique aspect is "The Playground", which implements a possibility to use R within the app by entering command codes.

The app is hosted [here](https://tuomonieminen.shinyapps.io/CLTdemo/) and can also be used locally from R:

```
if(!require(shiny)){
  install.packages("shiny")
  library(shiny)
}
runGitHub("Calculator","TuomoNieminen")
```
