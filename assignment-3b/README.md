# Gapminder Life Expectancy App

This is the repository for assignment 3B of the STAT 545B course. I opted to complete option B of this assignment: creating my own shiny app, which can be found [here](https://timcrowe91.shinyapps.io/GapminderApp/).

This app uses the Gapminder dataset to plot a density graph (along with providing other statistical information) of the life expectancies of all countries in the dataset for a specified year and, if chosen, a specified continent.

## Features of the App

Descriptions and justification can be found as comments in the code. An overview of the features is as follows:

### Inputs

* A slider which is used to change the year
* A choice of whether to select a specific continent or look at all continents combined

### Outputs

* A density graph showing the distribution of life expectancies, as well as the locations of the 1st, 2nd and 3rd quartiles
* Text information below the graph giving exact values of the quartiles along with the mean
* An image showing the highlighted continent(s)