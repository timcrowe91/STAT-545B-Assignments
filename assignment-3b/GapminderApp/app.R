library(shiny)
library(gapminder)
library(tidyverse)
library(shinythemes)

options(shiny.autoreload = TRUE)

# choices of continent selection
continents <- c("Africa", "Americas", "Asia", "Europe", "Oceania", "All Continents")

ui <- fluidPage(
    
    theme = shinytheme("yeti"),
    
    titlePanel("Distribution of Life Expectancies"),
 
    sidebarLayout(
        
        sidebarPanel(
            
            h5("Using data from the 'Gapminder' package, this app plots a density graph of life expectancies across different countries for a certain year, and shows where the 1st, 2nd and 3rd quartiles lie."),
            
            h5("You can use the slider to change the year you want to look at, and can choose to only consider data from countries of a selected continent"),
            
            # The first input is a slider allowing the user to choose which year to look at, allowing..
            # the user to scroll through and see the progression on the outputted plot
            
            sliderInput("filterYear", 
                        label = "Select Year",
                        min = 1952,
                        max = 2007,
                        value = 2007,
                        step = 5,
                        sep = ""),
            
            
            # The second input is the choice to highlight a particular continent, allowing the user to..
            # compare the density graphs between different parts of the world. 
            # The default is set so that no continent is highlighted and the entire dataset is..
            # considered - I felt this was better than suggesting a certain continent for the user..
            # to start with
            
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
    
    # The first output I define is a picture of the world map, with the chosen continent highlighted
    # This is purely for aesthetics, and I think it fits in well in the sidebar along with the inputs
    
    output$map<- renderImage({
        
        image_name = paste("www/", input$filterContinent, ".png", sep = "")
        list(src = image_name, width = "100%", height = "46%")
        
    }, deleteFile = FALSE)
        
    
    # This is the main focus of the app: the density plot
    # I chose to keep the min/max of the x axis constant throughout all plots as I feel it makes it..
    # easier and more intuitive to see how life expectancy has changed as time has passed, and between..
    # different continents. This does make Oceania pretty unreadable by itself due to it having much..
    # fewer countries, but I wanted to stay consistent with the design throughout

    output$plot <- renderPlot({

        gapminder_filtered <- gapminder %>%
            {if (input$filterContinent != "All Continents") filter(., continent == input$filterContinent) else .} %>%
            filter(year == input$filterYear)

        ggplot(gapminder_filtered, aes(lifeExp)) +
            geom_density(aes(xmin = 20, xmax = 100), fill = "grey") +
            geom_vline(aes(xintercept=median(lifeExp)), color="purple3", linetype = "dashed", size = 1) +
            geom_vline(aes(xintercept=quantile(lifeExp, 0.25)), color="purple3", linetype = "dashed", size = 0.6) +
            geom_vline(aes(xintercept=quantile(lifeExp, 0.75)), color = "purple3", linetype = "dashed", size = 0.6) +
            theme_bw() +
            labs(x = "Life Expectancy", y = "")

    })
    
    
    # Below here are the 4 text outputs: they give the values for mean, median, 1st and 3rd quartiles
    # This gives the user an exact number rather than having to infer an estimate from the graph
    
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


shinyApp(ui = ui, server = server)
