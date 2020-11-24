# Gapminder Life Expectancy App

This is the repository for assignment 3B of the STAT 545B course. I opted to complete option B of this assignment: creating my own shiny app, which can be found [here](https://timcrowe91.shinyapps.io/GapminderApp/).

You may modify this README accordingly to the instructions from assignment 3B, *including* modifying the title of the README to be the name of your app instead of the current "Welcome to your Assignment 3B!".

This app uses the Gapminder dataset to plot a density graph of the life expectancies of all countries in the dataset for a specified year and, if chosen, a specified continent.

## Features of the App

Descriptions and justification can be found as comments in the code. An overview of the features is as follows:

### Inputs

* A slider which is used to change the year
* A choice of whether to select a specific continent or look at all continents combined

### Outputs

* A density graph showing the distribution of life expectancies, as well as the locations of the 1st, 2nd and 3rd quartiles
* Text information below the graph giving exact values of the quartiles along with the mean
* An image showing the highlighted continent(s)