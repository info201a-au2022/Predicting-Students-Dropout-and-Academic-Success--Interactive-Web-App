library(shiny)
library(ggplot2)
library(dplyr)

data <- read.delim("data/dataset.csv")
getwd()

ui <- fluidPage(
  titlePanel("Predicting Students' Dropout and Academic Success"),
  
  # Main panel with tabs
  mainPanel(
    tabsetPanel(
      
      # Opening page with explanatory text
      tabPanel("Project Overview", 
               
      ),
      
      # Plot page
      tabPanel("Factors Affecting Undergraduate Success",
               sidebarLayout(
                 sidebarPanel(
                   
                 ),
                 mainPanel(
                   
                 )
               )
      ),
      
      tabPanel("Grade Changes Over Time", 
               sidebarLayout(
                 sidebarPanel(
                   
                 ),
                 mainPanel(
                   
                  
                 )
               )
      ),
      
      tabPanel("Economic Factors and Education", 
               sidebarLayout(
                 sidebarPanel(
                   
                 ),
                 mainPanel(
                   
                   
                 )
               )
      ),
      
      tabPanel("Conclusion", 
               
      ),
    )
  )
)


server <- function(input, output) {
}

shinyApp(ui = ui, server = server)
