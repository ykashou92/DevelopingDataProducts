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
              h2("Table"),
              tableOutput("table1")
      ),
      tabItem(tabName = "widgets",
              h2("Widgets")
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
              h3("ui.R"),
              tags$a(href="https://github.com/ykashou92/DevelopingDataProducts/blob/master/shiny-app/ui.R", "ui.R", icon = icon ("github")),
              h3("server.R"),
              tags$a(href="https://github.com/ykashou92/DevelopingDataProducts/blob/master/shiny-app/server.R", "server.R")
      )
    )
  )
)
)


