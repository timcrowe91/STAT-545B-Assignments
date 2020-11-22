library(shiny)
library(gapminder)
library(tidyverse)

# choices of continent selection
continents <- c("Africa", "Americas", "Asia", "Europe", "Oceania", "All Continents")


# automatically update while running app
options(shiny.autoreload = TRUE)


# Define UI for application 
ui <- fluidPage(
    
    titlePanel("Distribution of Life Expectancies"),
    
    sliderInput("filterYear", 
                label = "Select Year",
                min = 1952,
                max = 2007,
                value = 2007,
                step = 5,
                sep = ""),
    
    selectInput("filterContinent",
                "Choose a Continent", 
                choices = continents,
                selected = "All Continents"),
    
    
    # placeholder linking ui to server to create plot, "plot" id / tag called later
    plotOutput("plot")
    
)

# Define server logic 
server <- function(input, output) {
    
    output$plot <- renderPlot({
        
        gapminder_filtered <- gapminder %>%
            {if (input$filterContinent != "All Continents") filter(., continent == input$filterContinent) else .} %>%
            filter(year == input$filterYear)
        
        ggplot(gapminder_filtered, aes(lifeExp)) +
            geom_histogram(aes(xmin = 20, xmax = 90, binwidth = 5)) +
            theme_bw() + 
            labs(x = "Life Expectancy", y = "")
        
    })
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
