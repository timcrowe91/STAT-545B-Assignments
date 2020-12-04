# Assignment 4B

This repository contains my work for Assignment 4 for the STAT 545B class. The topic of the assignment is automation and the use of Makefiles.

The original Make activity was put together by Jenny Bryan's STAT 545 team before 2017, with the associated content available in [stat545.com Chapter 36: Automating Data Analysis Pipelines](https://stat545.com/automating-pipeline.html).

## Exercise 1

*Independently from any Makefile, indicate the code that you would run in the command line (Terminal) in order to run an `.R` file _in the background_, so that you can close your Terminal and have the code still run.*

The code needed to run an .R file in the background is:

`nohup Rscript script.R > log.out 2>&1 &`

Where:

* `script.R` is the file being run
* `nohup` makes the code run in the background
* `> log.out 2>&1` records output to log.out
* `&` (at the end) frees your terminal

## Exercise 2

*Modify one thing about the seeded analysis (add a file? add another output file?), and update the Makefile accordingly*

I added a bar plot which shows the proportion of words that contain each letter of the alphabet. I put the results in a 2nd report (report2.md).
