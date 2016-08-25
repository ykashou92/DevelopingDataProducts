# Load Necessary Libraries

library(plyr)
library(dplyr)
library(ggplot2)
library(ggmap)
library(shiny)
library(DT)
library(googleVis)

# Download, clean and subset dataset

url <- "http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv"
f <- file.path(getwd(), "all_month.csv")
download.file(url, f)
eq <- read.csv("all_month.csv", header = TRUE, sep = ",")
eq$loc <- paste(eq$latitude, eq$longitude, sep = ":")
eq.subset <- eq[ -c(11:13 ,15:22) ]
eq.ordered_time <- arrange(eq.subset, desc(as.factor(time)))
eq.ordered_mag <- arrange(eq.subset, desc(mag))
eq.ordered_depth <- arrange(eq.subset, desc(depth))

"%b/w%" <- function(x, ends) x >= ends[1] & x <= ends[2]

####################
### SHINY SERVER ###
####################

shinyServer(
  function(input, output) {
      
      # Top 5 Most Recent Earthquakes Table
      output$table1 <- renderTable({
                eq.table1 <- head(eq.ordered_time, 5)
      })
      
      # Top 10 Earthquakes by magnitude
      output$table2 <- renderTable({
                eq.table2 <- head(eq.ordered_mag, 10)
      })
      
      # Top 10 Earthquakes by depth
      output$table3 <- renderTable({
                eq.table3 <- head(eq.ordered_depth, 10)
      })

      # Calendar Range Entry    
      output$dateRangeText  <- renderText({
        paste("input$dateRange is", 
              paste(as.character(input$dateRange), collapse = " to ")
        )
      })
      
      # Custom Map based on 
      output$gviscustom <- renderGvis({
        limits <- input$magRange
        num <- input$num
        
        eq.custom <- subset(eq.subset, (eq.subset$mag %b/w% limits))
       
        if(nrow(eq.custom) < num && nrow(eq.custom) != 0) {
        output$error <- renderText({
          "The number of observations visible is lower that the number selected. There are a limited number of earthquakes in this range."
        })
        } 
        
        else if(nrow(eq.custom) == 0) {
          output$error <- renderText({
            "Please increase the magnitude range, there are no recorded earthquakes in this range."
        })
        }
        
        else {
          output$error <- renderText({
            ""
          })
          eq.custom <- eq.custom[sample(nrow((eq.custom)), num), ]
        }
        
        eq.mapcustom <- gvisMap(eq.custom, locationvar = "loc", tipvar = "mag",
        options = list(enableScrollWheel = TRUE,
                       mapType = "terrain",
                       useMapTypeControl = TRUE, 
                       chartid = 3))
      })   
           
          
      # Standard map
      output$gvis1 <- renderGvis({
                eq.map <- gvisMap(eq, locationvar = "loc", tipvar = "mag",
                            options = list(enableScrollWheel = TRUE,
                                          mapType = "terrain",
                                          useMapTypeControl = TRUE, 
                                          chartid = 1))
      return(eq.map)  
       })
      
      # Standard geochart
      output$gvis2 <- renderGvis({
                 eq.map <- gvisGeoChart(eq, locationvar = "loc", colorvar = "mag",
                              options = list(enableScrollWheel = TRUE,
                                         mapType = "terrain",
                                         useMapTypeControl = TRUE,
                                         sizeAxis.minValue = 0,
                                         chartid = 2))
        return(eq.map)  
      })
      
})