#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
     
     observe({
          
          # When user click Standard Normal Distribution, N(0,1)
          if(input$chkStdNorm) {
               updateTextInput(session, "mean", value = 0);
               updateTextInput(session, "std",  value = 1)
          }
          
          if(input$mean=="") 
               updateTextInput(session, "mean", value = 0)
          if(input$std == "") 
               updateTextInput(session, "std", value = 1)
          
          mu <- as.numeric(input$mean)
          sd <- as.numeric(input$std)
          step <- 1
          
          # Control the value and default range and step.
          # The range is from -3.5 sigma to 3.5 sigma. The default range is 20 % around mean
          min_pts <- round(mu - 3.5*sd)
          max_pts <- round(mu + 3.5*sd)
          if(mu!=0)  { inf <- as.numeric(mu*0.8)
          sup <- as.numeric(mu*1.2) 
          } else  { inf <- -1; sup<- 1 }
          
          updateSliderInput(session, "limits", value = c(inf,sup), 
                            min = min_pts, max = max_pts, step = step)
     })
     
     output$distPlot <- renderPlot({
          mean=as.numeric(input$mean)
          sd=as.numeric(input$std)
          
          low_lim=as.numeric(input$limits[1])
          upp_lim=as.numeric(input$limits[2])
          
          # plot normal distribution
          pts <- seq(-3.5,3.5,length=1000)*sd + mean
          den <- dnorm(pts,mean,sd)
          
          plot(pts, den, type="l", cex =10, xlab="Math Scores", ylab="Density", main="Normal Distribution"
               , axes =FALSE)
          
          # plot probability area under normal curve
          range <- pts >= low_lim & pts <= upp_lim
          polygon(c(low_lim,pts[range],upp_lim), c(0,den[range],0), col="red") 
          
          prob <- pnorm(upp_lim, mean, sd) - pnorm(low_lim, mean, sd)
          
          # Display where the average score in the distribution is
          arrows(mean, 0, mean, 1, col = "#c0c0c0", lty=2, lwd=2)
          
          # display probability area expression
          result <- paste("P(",low_lim,"< X <",upp_lim,") =", round(prob, 4))
          mtext(result, 3, cex=1.5, font=1)
          
          # show X axis, according to min and max limits
          min_pts <- floor(mean-3.5*sd)
          max_pts <- floor(mean+3.5*sd)
          step <- 5
          axis(1, at=seq(min_pts, max_pts, step), pos=0)
     })
}
)
