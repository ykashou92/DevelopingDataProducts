library(shiny)
library(shinydashboard)

shinyUI(dashboardPage(
  dashboardHeader(title = "Earthquakes"),
  dashboardSidebar(
    sidebarMenu(
    menuItem("Overview", tabName = "overview", icon = icon("dashboard"), 
             menuSubItem("Tables", tabName = "tables", icon = icon("table"))),
    menuItem("Widgets", tabName = "widgets", icon = icon("th")),
    menuItem("googleVis", tabName = "googleVis", icon = icon ("map")),
    menuItem("Source Code", tabName = "sourcecode", icon = icon ("code"))
  )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "overview",
              h2("Overview"),
              p("Hi")
      ),
      tabItem(tabName = "tables",
              h2("Tables"),
              h3("Top 5 Most Recent Earthquakes"),
              tableOutput("table1"),
              h3("Top 10 Earthquakes by Magnitude"),
              tableOutput("table2"),
              h3("Top 10 Earthquakes by Depth"),
              tableOutput("table3")
      ),        
      tabItem(tabName = "widgets",
              h2("Widgets"),
              dateRangeInput('dateRange',
                             label = 'Please Select a Date Range',
                             start = Sys.Date() - 2, end = Sys.Date() + 2
              )
      ),
      
      tabItem(tabName = "googleVis",
              h2("Earthquake Visualization using googleVis"),
              h3("Using gvisMap"),
              htmlOutput("gvis1"),
              h3("Using gvisGeoChart"),
              htmlOutput("gvis2")
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


