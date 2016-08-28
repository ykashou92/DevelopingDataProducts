####################
### SHINY SERVER ###
####################

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

shinyServer(
  function(input, output) {
      
      # TABLE SELECTION AND DISPLAY
      # STATIC TABLES
      output$tables <- renderTable({
        if (input$tablelist == "table1") {
          eq.table1 <- head(eq.ordered_time, 10)
        }
        else if (input$tablelist == "table2") {
          eq.table2 <- head(eq.ordered_mag, 10)
        }
        else if (input$tablelist == "table3") {
          eq.table3 <- head(eq.ordered_depth, 10)
        }
      })
      
      # DYNAMIC TABLE
      output$dyntables <- renderDataTable({
        if (input$tablelist == "dyntable") {
          eq.table4 <- eq.subset
        }
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
        
        ### PLOTLY ###
      output$xbins <- reactiveUI(function() {
        sliderInput("xbins", "Choose a value:",
                    min = 10, max = 40, step = 1, value = 25)
        })
      
        output$eq.plot_1 <- renderPlotly({
          hist1 <- ggplot(data = eq, aes(mag, fill = (..count..))) + geom_histogram(bins = input$xbins)
          p1 <- ggplotly(hist1)
          p1
        })
})
