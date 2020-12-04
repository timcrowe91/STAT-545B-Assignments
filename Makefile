all: assignment1 assignment3

clean:
	rm -f assignment-1b/assignment-1B.md
	rm -f assignment-1b/assignment-1B_files/figure-gfm/unnamed-chunk-4-1.png
	rm -f assignment-1b/assignment-1B_files/figure-gfm/unnamed-chunk-4-2.png
	rm -f assignment-1b/assignment-1B_files/figure-gfm/unnamed-chunk-4-3.png
	rm -f assignment-1b/assignment-1B_files/figure-gfm/unnamed-chunk-4-4.png
	cd assignment-4b/make-activity && make clean

assignment1: 
	Rscript -e "library(rmarkdown); render('assignment-1b/assignment-1B.Rmd')"
	rm assignment-1b/assignment-1B.html
	
assignment3:
	start chrome https://timcrowe91.shinyapps.io/GapminderApp/
	
assignment4:
	cd assignment-4b/make-activity && make all



# package:
# 	Rscript -e "install.packages('palmerpenguins', repos = 'http://cran.us.r-project.org')"
	
# package2:
# 	Rscript -e "library(devtools); install_github('UBC-MDS/datateachr')"