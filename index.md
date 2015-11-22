---
title       : Word Counter
subtitle    : Project for Developing Data Products
author      : Sur Tan (22 Nov 2015)
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## About Word Counter
----
'Words Counter' is a simple shiny application to count the number of words and characters of a text. It also finds the top 10 words most frequently used and the percentage each word is used within the text.

https://sur-tan.shinyapps.io/shinyapp

How to Use:
- Type or paste the text in the input text box.
- Click 'Count' button. 
- The output will be displayed in the 'Summary' section.

Limitations:

'Word Counter' makes its own assumption to define the meaning of a word. Refer to next slide on those assumptions.  

---

## How It Works
----
'Word Counter' makes the following assumptions to process the text: 

- Space is the separator of words. 
- Carriage return separates two different paragraphs, so it is converted to a space to separate the last word from the current paragraph to the first word of the next paragrah.
- Double, leading or trailing spaces are removed first as they will include as an additional count when there is no word tie to these spaces.

- Carriage return is not considered as a character, so it is removed before counting number of characters.
- Some words are together with other special characters such as question mark, apostrophe, etc, e.g. 'How?'. When counting the top 10 frequently used words, these will be removed so that 'How' and 'How?' are considered the same words. Note: only a few special characters are included here: ? , . ! " ' ( )  
- The words are all changed to small case before counting.

---

## Codes Example
----


The codes are too long to be shown here. Refer to ui.R and server.R at https://github.com/sur-tan/DevelopingDataProduct for the complete source codes. 

This is the example how the three main functions (countWords, countChars and findtop10) are called with the sample input text to produce the results.


```r
sample_text <- "This is my project for the Developing Data Proudct course, 
Coursera Data Science Specialization. The project is due on 22 Nov 2015. 
It is a simple shiny application that counts the number of words, characters
and find the top 10 frequently used words and its percentage."

numChars <- countChars(sample_text)
numWords <- countWords(sample_text)
```

The number of characters: ***269***.
The number of words: ***46***.


---

## Codes Example
----

The top 10 frequently used words are: 

```r
findtop10(sample_text)
```

```
##       Word Count Percent
## 1      the     4   8.7 %
## 2       is     3  6.52 %
## 3      and     2  4.35 %
## 4     data     2  4.35 %
## 5  project     2  4.35 %
## 6    words     2  4.35 %
## 7       10     1  2.17 %
## 8     2015     1  2.17 %
## 9       22     1  2.17 %
## 10       a     1  2.17 %
```
