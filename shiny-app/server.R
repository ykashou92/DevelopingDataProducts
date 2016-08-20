library(plyr)
library(dplyr)
library(ggplot2)
library(ggmap)
library(shiny)
library(DT)

url <- "http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv"
f <- file.path(getwd(), "all_month.csv")
download.file(url, f)
eq <- read.csv("all_month.csv", header = TRUE, sep = ",")

shinyServer(
  function(input, output) {
    
    # Single zoomable plot
    ranges <- reactiveValues(x = -180:180, y = -90:90)
    
    output$newMap <- renderPlot({
      #eq
      i <- input$i
      eq.mag <- subset(eq, eq$mag == i)
      dim(eq.mag)
      eq.sorted <- arrange(eq.mag, desc(mag))
      eq.mod <- select(eq.sorted, latitude, longitude, mag)
      filter(eq.mod, between(longitude, -90, 90), between(latitude, -180, 180)) -> inside
      eq.mod <- setdiff(eq.mod, inside)
      wmap <- borders("world", colour = "gray50", fill="white")
      
      # Earthquakes with Mag > 0 (All recorded seismic events)
      eq_map <- ggplot() + wmap
      eq_map <- eq_map + geom_point(data = eq.mod, aes(x = as.numeric(longitude), y = as.numeric(latitude), colour = mag)) + coord_cartesian(xlim = ranges$x, ylim = ranges$y) + ggtitle("Earthquakes with Mag > 0 (All recorded seismic events)") + xlab("Longitude") + ylab("Latitude") + scale_size_identity()
      sc2 <- scale_colour_gradientn(colours = "darkred", limits=c(0, 8))
      eq_map + sc2
    })
    
    output$results <- renderDataTable({
      i <- input$i
      eq.mag <- subset(eq, eq$mag == i)
      eq.dat <- datatable(head(eq.mag, 10), class = 'cell-border stripe')
      eq.dat
    })
    
    # When a double-click happens, check if there's a brush on the plot.
    # If so, zoom to the brush bounds; if not, reset the zoom.
    observeEvent(input$newMap_dblclick, {
      brush <- input$newMap_brush
      if (!is.null(brush)) {
        ranges$x <- c(brush$xmin, brush$xmax)
        ranges$y <- c(brush$ymin, brush$ymax)
        
      } else {
        ranges$x <- -180:180
        ranges$y <- -90:90
      }
    })
  }
)
