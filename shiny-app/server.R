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
eq.subset <- eq[ -c(11:13 ,15:22) ]
eq$loc <- paste(eq$latitude, eq$longitude, sep = ":")
eq.subset.ordered <- arrange(eq.subset, desc(mag))

shinyServer(
  function(input, output) {
      
      output$table1 <- renderTable({
                eq.table1 <- head(eq.subset.ordered, 15)
      })
    
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