all: report.html report2.html

clean:
	rm -f words.txt histogram.tsv histogram.png report.md report.html letters.png report2.md report2.html

report.html: report.rmd histogram.tsv histogram.png
	Rscript -e "rmarkdown::render('$<')"

histogram.png: histogram.tsv
	Rscript -e "library(ggplot2); qplot(Length, Freq, data=read.delim('$<')); ggsave('$@')"
	rm Rplots.pdf

histogram.tsv: histogram.r words.txt
	Rscript $<
		
report2.html: report2.Rmd letters.png
	Rscript -e "rmarkdown::render('$<')"
	
letters.png: letters.R words.txt
	Rscript $<
	rm Rplots.pdf


# words.txt: /usr/share/dict/words
# 	cp $< $@

words.txt:
	Rscript -e "download.file('http://svnweb.freebsd.org/base/head/share/dict/web2?view=co', destfile = 'words.txt', quiet = TRUE)"
	
# package:
# 	Rscript -e "install.packages('ggplot2', repos = 'http://cran.us.r-project.org')"