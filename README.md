![](app.png)

# Welcome to the CIdemo repository

This repository includes the codes for an R Shiny interactive demonstration of frequentistic confidence intervals.

# About

R is a programming language for data analysis. Shiny is an R library for creating interactive web applications.  

This app gives an easily accessible interactive demonstration which allows the user explore frequentistic confidence intervals. A very unique aspect of the app is "The Playground" designed for advanced users who know the R language. The Playground implements a possibility to use R within the app by entering command codes. Each part of the demonstration includes a possibility to explore the concepts with R.

# Usage

The app is hosted [here](https://tuomonieminen.shinyapps.io/CIdemo/) and can also be used locally from R with the following code

```
if(!require(shiny)) install.packages("shiny")
shiny::runGitHub("CIdemo","TuomoNieminen")
```
