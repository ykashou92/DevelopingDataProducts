################
### SHINY UI ###
################

library(shiny)
library(shinydashboard)

shinyUI(dashboardPage(
  dashboardHeader(title = "Earthquake Monthly"),
  dashboardSidebar(
    sidebarMenu(
    menuItem("Documentation", tabName = "documentation", icon = icon("dashboard")), 
    menuItem("Widgets", tabName = "widgets", icon = icon("gear"),
        menuSubItem("Map Controller", tabName = "control", icon = icon("map")),
        menuSubItem("Table Explorer", tabName = "tables", icon = icon("table")),
        menuSubItem("Chart Plotter", tabName = "charts", icon = icon("bar-chart"))),
    menuItem("Source Code", tabName = "sourcecode", icon = icon ("code"))
  )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "documentation",
              h2("Documentation"),
              p("This shiny web application was created to fulfill the project requirements for the 
                Developing Data Products MOOC offered on Coursera by John's Hopkins University as part of their Data Science Specialization."),
              p("In the project outline, we were told the app is totally up to us, and hence I decided to use the USGS Earthquake Feed as my source."),
              p("You can manually download the dataset from their website for free at:"),
              tags$a(href="http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv", "http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv"), 
              p(""),
              p("The dataset is automatically updated every 15 minutes and hence you will find the most recent earthquakes on the news in this dataset"),
              p(""),
              p("On the left side of the screen you can navigate to various tabs and explore the app as you will,
                under 'Widgets', you will find 'Controllers' and 'Tables', these are the bread and butter of the app, they are where the data exploration and analyses occur.
                Under 'googleVis' you will find a plot of the world's earthquakes as per defined in the 'Controllers' tab.
                Finally, please visit the 'Source Code' tab for access to ui.R and server.R, as well as the GitHub Repository containing this app. Enjoy!"),
              h4("- Yanal Kashou")
      ),
      tabItem(tabName = "widgets",
              h2("Widgets")
      ),
      tabItem(tabName = "control",
              h2("Controllers"),
              p("Feel free to play around with these controllers. They modify the dataset according to
                magnitude and observation number"),
              p("A new gvisMap will be automatically generated according to your specifications"),
              sliderInput("magRange", "Select the magnitude range", value = c(0, 10), min = 0, max = 10, step = 1),
              sliderInput("num", "How Many Earthquakes would you like me to display?", value = 50, min = 0, max = 100, step = 1), 
              h3("Custom googleVis Map"),
              strong(textOutput("error")),
              p(""),
              htmlOutput("gviscustom")
      ),
      tabItem(tabName = "tables",
              h2("Tables"),
              selectInput("tablelist", "Choose your table:", choices = c('10 Most Recent Earthquakes'= "table1",
                                                                         '10 Strongest Earthquakes'= "table2",
                                                                         'Top 10 Earthquakes by Depth'= "table3",
                                                                         'Dynamic Earthquake Table' = "dyntable")),
              tableOutput("tables"),
              dataTableOutput("dyntables")
      ),
      tabItem(tabName = "charts",
              h2("Earthquake Frequency"),
              h2("Earthquake Heatmap")
              ),
      tabItem(tabName = "sourcecode",
              h2("Source Code"),
              h3("Link to GitHub Repo"),
              tags$a(href="https://github.com/ykashou92/DevelopingDataProducts", "GitHub Repository"),
              h3("ui.R"),
              tags$a(href="https://github.com/ykashou92/DevelopingDataProducts/blob/master/shiny-app/ui.R", "ui.R"),
              h3("server.R"),
              tags$a(href="https://github.com/ykashou92/DevelopingDataProducts/blob/master/shiny-app/server.R", "server.R")
      )
    )
  )
)
)


