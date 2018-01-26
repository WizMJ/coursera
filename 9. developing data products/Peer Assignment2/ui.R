### Subject: Developing Data Products - Peer Assignment
### Date   : Jan. 26th, 2018
### Author : Minki Jo
### ---------------------------------------------------

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
     # Title
     titlePanel("Normal Distribution vs Standard Normal Distribution"),
     sidebarLayout(
          sidebarPanel(
               h5("What is your calss' average and standard deviation of math test:"),	
               textInput(inputId="mean", label = "Average Score", value=70),
               textInput(inputId="std", label = "Standard Deviation", value=5),
               sliderInput("limits", label = "Math Score Range", 
                           min = 0, max = 100, value = c(50, 90)),
               checkboxInput("chkStdNorm", "Click if want to see Standard Normal Distribution", FALSE)
          ),
          
          mainPanel(
               tabsetPanel(
                    tabPanel("Plot", plotOutput("distPlot"))
               )
          )
     )
)
)
