Assignment 3-B
================
Tim Crowe

  - **Leader**: Iciar Fernandez

  - **Reviewer**: Almas Khan & Vincenzo Coia

  - **Deadline**: Saturday, November 21, 2020 at 23:59 PST

  - **Total Points**: 20

## Overview

In Assignment 2-B, you practiced creating an R package. This week, we’ll
be creating a Shiny dashboard\! You may complete Option A or Option B of
this assignment (*not both*), detailed as follows:

  - **Option A:** Add three features to an already-existing BC Liquor
    shiny app, and deploy it.
  - **Option B:** Create your own shiny app with three features, and
    deploy it.

Read all the instructions in this document *thoroughly* before
proceeding with your assignment. The grading rubric is detailed at the
very end, and *it doubles as a checklist* for you to keep track of your
progress\!

## Acknowledgements

This homework was originally developed by Dean Attali, with
modifications by Giulio Valentino Dalla Riva, and has been further
modified for 2020.

## Setup

*An important note before you start* - it’s easy to get carried away
adding lots of design features to a Shiny app, but we’re only expecting
simplicity. Design choice is undoubtedly important, but we are mostly
focusing on your ability to make these apps. This will be reflected
accordingly in the grading rubric, but we encourage you to keep it in
mind as you work through the assignment.

  - You will be working within an assignment-3b folder in your homework
    repo. You will see the “basic” BC Liquor Store app already there.
    Just delete this if you want to build your own app (Option B).
  - Think about whether you want to choose Option A or B.
  - Plan out your app - whether you are modifying the existing BC Liquor
    dashboard or creating your own app, read through the feature ideas
    and rubric below, browse through the Shiny app examples, and have a
    clear plan before you start. This will save you time later\!
  - Get started. Remember to use the rubric as a checklist to ensure
    that you’ve completed all the steps, and have fun\!

## Feature ideas

There are countless possibilities for features, but here are just a few
ideas. You can choose any 3 or more ideas from this list or do anything
else\! Note that many of the examples in this list refer to the BC
Liquor app, but they are all still applicable to creating your own Shiny
app if that is your chosen option for the assignment. Want more ideas
than what’s below? Check
[this](https://rstudio.github.io/shiny/tutorial/#welcome) out.

#### If you have a table in your app…

  - Add an option to sort the table by one of your variables (as an
    example, in the BC Liquor app, you could sort the results by
    price\!).
      - *Hint:* Use `checkboxInput()` to get `TRUE`/`FALSE` values from
        the user.
  - Use the DT package to turn a static table into an interactive table.
      - *Hint:* Install the DT package, replace `tableOutput()` with
        `DT::dataTableOutput()` and replace `renderTable()` with
        `DT::renderDataTable()`.
  - Show the number of results found whenever the filters change. For
    example, in the BC Liquor app, when searching for Italian wines
    `$20` - `$40`, the app would show the text “We found 122 options for
    you”.
      - *Hint:* Add a `textOutput()` to the UI, and in its corresponding
        `renderText()` use the number of rows in the `filtered()`
        object.
  - Allow the user to download your table as a .csv file.
      - *Hint:* Look into the `downloadButton()` and `downloadHandler()`
        functions.
  - Allow the user to search for multiple entries simultaneously; for
    example, in the BC Liquor app, allow the user to search for multiple
    alcohol types at once instead of wine/beer/etc, one at a time.
      - *Hint:* There are two approaches to do this. Either change the
        typeInput radio buttons into checkboxes (`checkboxGroupInput()`)
        since checkboxes support choosing multiple items, or change
        typeInput into a select box (`selectInput()`) with the argument
        `multiple = TRUE` to support choosing multiple options.

#### If you have a plot in your app…

  - Add parameters to the plot.
      - *Hint:* You will need to add input functions that will be used
        as parameters for the plot. You could use
        `shinyjs::colourInput()` to let the user decide on the colours
        of the bars in the plot.

#### Other ideas:

  - Add an image to the UI. In the case of the BC Liquor app, you could
    add an image of the BC Liquor Store. If you’re building your own app
    from scratch, an image may make your app more visually interesting
    or add information\!
      - *Hint:* Place the image in a folder named www, and use `img(src
        = "imagename.png")` to add the image.
  - If you know CSS, add CSS to make your app look nicer.
      - *Hint:* Add a CSS file under www and use the function
        `includeCSS()` to use it in your app.
  - Experiment with packages that add extra features to Shiny, such as
    shinyjs, leaflet, shinydashboard, shinythemes, ggvis.
      - *Hint:* Each package is unique and has a different purpose, so
        you need to read the documentation of each package in order to
        know what it provides and how to use it.
  - If you have both a plot and a table, place them in separate tabs.
      - *Hint:* Use `tabsetPanel()` to create an interface with multiple
        tabs.

## Shiny app examples

Here are some examples of apps built with Shiny - we don’t expect you to
achieve the level of complexity in any of these, but they are examples
that may inspire you in terms of what you want to do with your own app\!

  - [Biodiversity of National
    Parks](https://abenedetti.shinyapps.io/bioNPS/?_ga=2.2513072.1250661063.1604984182-1784159993.1567907747)
  - [Fuel economy of cars in the
    US](https://jgassen.shinyapps.io/expand_fuel_economy/?_ga=2.232610335.1250661063.1604984182-1784159993.1567907747)
  - [Tidy Tuesday Tweet
    Catalogue](https://nsgrantham.shinyapps.io/tidytuesdayrocks/?_ga=2.224403354.1250661063.1604984182-1784159993.1567907747)
  - [Movie
    Explorer](http://shiny.rstudio-staging.com/gallery/movie-explorer.html)

## Rubric

### Tidy Submission (5 points)

Follow these steps to submit your work. Be sure to familiarize yourself
with the rubric for a tidy submission below, before doing these steps.

  - [x] (1 pts) Update your main `README` for your *assignment
    repository* (i.e. `stat-545b-assignments-GitHub-Username`) **with a
    link to a running instance of your Shiny app.**
  - [ ] (3 pts) Make a `README` within your `assignment-3b` folder. The
    README must include:
      - Your choice of assignment clearly stated: Option A - BC Liquor
        app, or Option B - your own Shiny app.
      - A description of your app. In the case of Option A, write about
        what makes your app different from the “basic” version after
        implementing your chosen features.
      - A link to the URL where the app is hosted.
      - Whatever dataset you will use, acknowledge its source clearly.
        Remember that we value open, reproducible science: this means
        that the user of your app should have direct access to the data,
        or know where to go to access it.
  - [ ] (1 pts) Tag a release in your assignment repository.
  - [ ] Submit a link to your tagged release in your assignment
    repository to canvas.
  - [ ] (Optional) When you submit to canvas, we would appreciate
    hearing about your experience with this assignment: what was
    hard/easy, problems you solved, helpful tutorials you read, things
    you liked or would have preferred to see, etc. No need to write lots
    here, this just allows us to make improvements for next year.

### Shiny app development (15 points)

  - There are three features in your Shiny app. Clearly state which
    three features you are modifying or creating in your code, with
    comments. Specifically, *write a sentence per feature explaining how
    it is useful*. (12 pts, 4 per feature)
      - **Option A:** Adding three features to the already existing BC
        Liquor app.
          - [ ] There’s at least one new functional widget that modifies
            at least one output. (4 pts)
          - [ ] There’s at least one change to the UI (aside from the
            addition of a widget). (4 pts)
          - [ ] A third feature, whether it’s a change to the UI, or a
            functional widget. (4 pts)
      - **Option B:** Create your own shiny app with three features, and
        deploy it.
          - [x] Feature 1. (4 pts)
          - [x] Feature 2. (4 pts)
          - [x] Feature 3. (4 pts)
      - *What are we looking for in your features?*
          - *Variety.* Including three tables as part of your dashboard
            and having the same exact feature for each of them (e.g. a
            filtering option, even if the tables are distinct) will be
            penalized; at least 2 of the 3 features must be unique.
          - For either option A or B, we will evaluate the *usefulness*
            of your features in the context of your app (does it add to
            the user experience?). We expect your features to be
            sensible, meaning that they add to the user experience in a
            way that makes sense - as an example, adding a filtering
            option for “country” in a table that only has data for
            Canada does not seem very useful, even if you added the
            filtering feature correctly. If we consider any of your
            features to be irrelevant for the app, 0.5pts will be
            penalized for that particular feature.
  - RRR (3 pts):
      - [x] Code runs without errors and it is appropriately annotated,
        legible, and easy to follow. (1.5 pts)
      - [x] Your app should be deployed online on shinyapps.io (or on
        another server if you’d like). Make sure your app actually works
        online (sometimes your app will work in RStudio but will have
        errors on shinyapps.io - make sure you deploy early and often to
        make debugging easier). (1.5 pts)

**Submit the link to your tagged release in Canvas when you have
finished all of the above and your assignment.**
