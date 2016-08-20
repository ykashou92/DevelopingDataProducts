library(shiny)

shinyUI(pageWithSidebar(
    headerPanel("Earthquake Magnitude visualization"),
    sidebarPanel(
        sliderInput('i', 'Earthquake Magnitude', 4, min = 0, max = 8, step = 0.1)
    ),

    mainPanel(
       plotOutput('newMap',
       dblclick = "newMap_dblclick",
       brush = brushOpts(
         id = "newMap_brush",
         resetOnNew = TRUE
       )),
       dataTableOutput( "results" )
    )
    )
)
