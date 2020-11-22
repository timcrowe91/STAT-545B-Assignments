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
 
    sidebarLayout(
        
        sidebarPanel(
            
            h4("Using figures from the 'Gapminder' dataset, this app plots a density graph of life expectancies, and shows where the 1st, 2nd and 3rd quartiles lie. You can use the slider to change the year you want to look at, and can choose to highlight a specific continent"),
            
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
            
            imageOutput("map")
            
        ),
        
        mainPanel(
            
            plotOutput("plot"),
            
            textOutput("mean"),
            
            textOutput("median"),
            
            textOutput("firstquart"),
            
            textOutput("thirdquart")
            
        )
    )
)

# Define server logic 
server <- function(input, output) {
    
    output$map<- renderImage({
        
        image_name = paste("www/", input$filterContinent, ".png", sep = "")
        list(src = image_name, width = 340, height = 155)
        
    }, deleteFile = FALSE)
        


    output$plot <- renderPlot({

        gapminder_filtered <- gapminder %>%
            {if (input$filterContinent != "All Continents") filter(., continent == input$filterContinent) else .} %>%
            filter(year == input$filterYear)

        ggplot(gapminder_filtered, aes(lifeExp)) +
            geom_density(aes(xmin = 20, xmax = 100), fill = "grey") +
            geom_vline(aes(xintercept=mean(lifeExp)), color="purple3", linetype = "dashed", size = 1) +
            geom_vline(aes(xintercept=quantile(lifeExp, 0.25)), color="purple3", linetype = "dashed", size = 0.6) +
            geom_vline(aes(xintercept=quantile(lifeExp, 0.75)), color = "purple3", linetype = "dashed", size = 0.6) +
            theme_bw() +
            labs(x = "Life Expectancy", y = "")

    }, width = 700, height = 400)
    
    output$mean <- renderText({
        
        gapminder_filtered <- gapminder %>%
            {if (input$filterContinent != "All Continents") filter(., continent == input$filterContinent) else .} %>%
            filter(year == input$filterYear)
        
        paste("Mean life expectancy:", round(mean(gapminder_filtered$lifeExp), digits = 1), "years", sep = " ")

    })
    
    output$median <- renderText({
        
        gapminder_filtered <- gapminder %>%
            {if (input$filterContinent != "All Continents") filter(., continent == input$filterContinent) else .} %>%
            filter(year == input$filterYear)
        
        paste("Median life expectancy:", round(median(gapminder_filtered$lifeExp), digits = 1), "years", sep = " ")
        
    })
    
    output$firstquart <- renderText({
        
        gapminder_filtered <- gapminder %>%
            {if (input$filterContinent != "All Continents") filter(., continent == input$filterContinent) else .} %>%
            filter(year == input$filterYear)
        
        paste("First quartile:", round(quantile(gapminder_filtered$lifeExp, 0.25), digits = 1), "years", sep = " ")
        
    })
    
    output$thirdquart <- renderText({
        
        gapminder_filtered <- gapminder %>%
            {if (input$filterContinent != "All Continents") filter(., continent == input$filterContinent) else .} %>%
            filter(year == input$filterYear)
        
        paste("Third quartile:", round(quantile(gapminder_filtered$lifeExp, 0.75), digits = 1), "years", sep = " ")
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
