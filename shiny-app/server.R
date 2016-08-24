library(plyr)
library(dplyr)
library(ggplot2)
library(ggmap)
library(shiny)
library(DT)
library(googleVis)

url <- "http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv"
f <- file.path(getwd(), "all_month.csv")
download.file(url, f)
eq <- read.csv("all_month.csv", header = TRUE, sep = ",")
eq$loc <- paste(eq$latitude, eq$longitude, sep = ":")
eq.subset <- eq[ -c(11:13 ,15:22) ]
eq.ordered_time <- arrange(eq.subset, desc(as.factor(time)))
eq.ordered_mag <- arrange(eq.subset, desc(mag))
eq.ordered_depth <- arrange(eq.subset, desc(depth))

#eq$converted.time <- as.POSIXct( eq$time , format = "%y/%m/%dT%H:%M:%S" , tz = "GMT")
#eq[ order(eq$converted.time , decreasing = TRUE ),]

#2016-07-29T21:18:26.510Z

shinyServer(
  function(input, output) {
      
      output$table1 <- renderTable({
                eq.table1 <- head(eq.ordered_time, 5)
      })
    
      output$table2 <- renderTable({
                eq.table2 <- head(eq.ordered_mag, 10)
      })
      
      output$table3 <- renderTable({
                eq.table3 <- head(eq.ordered_depth, 10)
      })
    
      output$dateRangeText  <- renderText({
        paste("input$dateRange is", 
              paste(as.character(input$dateRange), collapse = " to ")
        )
      })
      
      output$gviscustom <- renderGvis({
        num <- input$num
        eq.num.custom <- eq.subset[sample(nrow(eq.subset), num), ]
#        magRange <- input$magRange
#        eq.mag.custom <- reactive(head(eq.subset, magRange))
        
#        dateRange <- input$dateRange
#        eq.date.custom <- reactive(head(eq.subset, dateRange))
        
        eq.mapcustom <- gvisMap(eq.num.custom, locationvar = "loc", tipvar = "mag",
                          options = list(enableScrollWheel = TRUE,
                                         mapType = "terrain",
                                         useMapTypeControl = TRUE, 
                                         chartid = 1))
      })
      
#      num <- input$num
#      eq.num <- reactive(head(eq.ordered))
#      mag <- input$magrange  
#      output$mag <- reactive(head(eq.ordered_mag))
      
      output$gvis1 <- renderGvis({
                eq.map <- gvisMap(eq, locationvar = "loc", tipvar = "mag",
                            options = list(enableScrollWheel = TRUE,
                                          mapType = "terrain",
                                          useMapTypeControl = TRUE, 
                                          chartid = 1))
      return(eq.map)  
       })
      
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