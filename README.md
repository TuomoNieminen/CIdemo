![](https://github.com/TuomoNieminen/CIdemo/blob/master/app.PNG)

# Welcome to the CIdemo repository

The CIdemo app gives an easily accessible interactive demonstration of frequentistic confidence intervals (CI's).  

A very unique aspect of the app is "The Playground", which is designed for advanced users who know the R language. The Playground implements a possibility to use R within the app by entering command codes. Each part of the demonstration includes a possibility to explore the concepts with R.

# About

R is a programming language for data analysis. Shiny is an R library for creating interactive web applications. This repository includes the codes for an R Shiny interactive demonstration of frequentistic confidence intervals.

# Usage

The app is hosted [here](https://tuomonieminen.shinyapps.io/CIdemo/) and can also be used locally from R with the following code

```
if(!require(shiny)) install.packages("shiny")
shiny::runGitHub("CIdemo","TuomoNieminen")
```
