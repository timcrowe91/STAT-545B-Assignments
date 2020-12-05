Assignment 5-B Answers
================
Tim Crowe

  - **Leader**: Victor Yuan

  - **Reviewer**: Diana Lin & Vincenzo Coia

  - **Deadline**: Saturday, December 12, 2020 at 23:59 PST

  - **Total Points**: 20

## Option A – Strings in R

Complete the following two exercises using concepts and tools covered in
class (i.e. `stringr`, regex, tidyverse, etc.)

### Exercise 1 (9 points)

*Take a Jane Austen book contained in the `janeaustenr` package, or
another book from some other source. Make a plot of the most common
words in the book, removing “stop words” of your choosing (words like
“the”, “a”, etc.) or stopwords from a pre-defined source, like the
`stopwords` package or `tidytext::stop_words`.*

I will be analysing the book “Emma” by Jane Austen to find the most
common words. For the “stop words”, I will use the `stopwords` package.

The `janeaustenr` package provides a character vector which contains the
entire text of the novel “Emma” (along with her other novels). In order
to do the analysis on this novel, I will remove all punctuation and
change all upper case characters to lower case.

I will then create a tibble in which every single word in the novel is
it’s own row, and remove all the words contained in the list mentioned
previously in order to show what the most common words in the novel are.

Step by step annotations of what I am doing is provided in the code:

``` r
# use stopwords package and take default list of words to remove from the results
stopwords_list <- stopwords(language = "en", source = "snowball", simplify = TRUE)

# remove punctuation and convert all letters to lower case
emma_words_simplified <- emma %>%
  str_remove_all("[^ a-zA-Z]") %>%
  str_to_lower()

# create tibble for dplyr analysis
emma_tibble <- enframe(emma_words_simplified, value = "Text")

# modify tibble to get desired list of most common words in the book
emma_common_words <- emma_tibble %>%
  separate_rows(Text, sep = " ") %>% # make each word in text be it's own row
  rename(Word = Text) %>%
  filter(Word %in% stopwords_list == FALSE) %>% # remove words from the stoplist
  filter(Word != "") %>% # remove empty entries
  count(Word) %>%
  arrange(desc(n))
```

Now we have a tibble of all the unique words in the novel, except those
found in `stopwords_list`, in descending order from most common to
least. A plot of the 30 most common words follows:

``` r
emma_common_words %>%
  top_n(30) %>%
  ggplot(aes(x = reorder(Word, n), y = n)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(y = "# Occurences", x = "") +
  theme_bw()
```

    ## Selecting by n

![](assignment-5B-answers_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

### Exercise 2 (9 points)

*Make a function that converts words to your own version of Pig Latin.*

*The specific input and output that you decide upon is up to you. Don’t
forget to implement good function-making hygiene: we’ll be looking for
documentation (being sure to describe your Pig Latin conversion),
examples of applying the function, 3 non-redundant tests, appropriate
use of arguments, and appropriate amount of checking for proper input.*

*Your Pig Latin should incorporate two components:*

**Rearrangement component**

*The default Pig Latin rearrangement rule, [as per
Wikipedia](https://en.wikipedia.org/wiki/Pig_Latin#Background), moves
beginning letters to the end:*

> 1.  For words that begin with consonant sounds, all letters before the
>     initial vowel are placed at the end of the word sequence.
> 2.  When words begin with consonant clusters (multiple consonants that
>     form one sound), the whole sound is added to the end
> 3.  For words beginning with vowel sounds, one removes the initial
>     vowel(s) along with the first consonant or consonant cluster.

*Modify this somehow. Maybe you move letters from the end to the
beginning, or you change the rules altogether, keeping a similar level
of complexity.*

**Addition component**

*The default Pig Latin addition rule is to add “ay” to the end of the
word, after rearranging the letters of the word. You should choose some
other addition rule.*

### The Function

``` r
pig_latin <- function(word, reverse = TRUE){
 
  if(str_detect(word, "[^a-zA-Z]")) stop("Please choose a single word consisting only of letters of the alphabet")
  if(str_detect(word, "[aeiouAEIOU]", negate = TRUE)) stop("Please choose a word containing at least one vowel and one consonant")
  if(str_detect(word, "[^aeiouAEIOU]", negate = TRUE)) stop("Please choose a word containing at least one vowel and one consonant")
  if(str_detect(word, "[A-Z]")) message("Word converted to lower case")
  
  vowel_pos <- str_locate(word, "[aeiouAEIOU]")[1] # find position of first vowel
  
  word %>%
    str_to_lower(.) %>% # lower case
    gsubfn(".", list("a" = "e", "e" = "i", "i" = "o", "o" = "u", "u" = "a"), .) %>% # shift vowels
    {if (vowel_pos == 1) # output - depending on whether word starts with vowel or not
      paste0(., "woo") 
      else 
      paste0(str_sub(., vowel_pos, -1), 
             {if (reverse)
               paste0(rev(str_split(str_sub(., 1, vowel_pos - 1), "")[[1]]), collapse = "") # reverse order of consonants
               else
               paste0(str_sub(., 1, vowel_pos - 1))},
             "oo")}
    
}
```

#### Description

My “version” of Pig Latin uses the following logic:

1.  If the word begins with a consonant, all letters up until the first
    vowel are removed and placed at the end of the word in reverse order
    if `reverse = TRUE` or in unchanged order otherwise
2.  All vowels in the word are replaced with the next vowel
    alphabetically (ie “a” becomes “e”, “e” becomes “i”, “i” becomes
    “o”, “o” becomes “u” and finally “u” loops back over and becomes
    “a”)
3.  If the word begins with a consonant then “oo” is added to the end of
    it, if it begins with a vowel then “woo” is added to the end

#### Example

Take the word “spring” using `reverse = TRUE`. From the steps above we
get:

1.  The word begins with a consonant, so we take all consonants up until
    the first vowel (“spr”), and move them to the end of the word in
    reverse order. This gives us “ingrps”
2.  “i” is the only vowel in the word, so this becomes an “o”, giving us
    “ongrps”
3.  As it began with a consonant, we add “oo” to the end of it, finally
    giving us “ongrpsoo”

We can confirm this (along with showing some other examples):

``` r
pig_latin("spring")
```

    ## [1] "ongrpsoo"

``` r
pig_latin("spring", reverse = FALSE)
```

    ## [1] "ongsproo"

``` r
pig_latin("five")
```

    ## [1] "ovifoo"

``` r
pig_latin("onomatopoeia")
```

    ## [1] "unumetupuioewoo"

``` r
pig_latin("waterfall")
```

    ## [1] "etirfellwoo"

#### Arguments

  - `word`: The word to be put into the function. This should contain
    only letters of the alphabet, and have at least one vowel and one
    consonant
  - `reverse`: Reverses the order of the consonant group (if applicable)
    that gets moved from the start of the word to the end. Default set
    to `TRUE`

#### Errors / Messages

An error message will be shown if:

  - `word` argument contains anything other than letters of the alphabet
  - `word` argument doesn’t contain at least one vowel and one consonant

Additionally, if the input contains upper case letters, a message is
written advising that the word has been converted to lower case:

``` r
pig_latin("STATISTICS")
```

    ## Word converted to lower case

    ## [1] "etostocstsoo"

#### Tests

``` r
test_that("pig_latin tests", {
  
  expect_error(pig_latin("ooooo"))
  expect_error(pig_latin("hello there"))
  expect_error(pig_latin("x"))
  expect_error(pig_latin("what?"))
  expect_equal(pig_latin("knight"), "oghtnkoo")
  expect_equal(pig_latin("knight", reverse = FALSE), "oghtknoo")
  expect_equal(pig_latin("hello"), "illuhoo")
  expect_equal(pig_latin("underwater"), "andirwetirwoo")
  
})
```

    ## Test passed
