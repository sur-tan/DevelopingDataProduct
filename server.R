library(shiny)
library(plyr)

## Word Counter Server
##
## This is the server processing of the shiny application to count the number of words and characters of a text.
## It will take in the input text and count the number of words, number of characters and find the top 10 of the
## most frequently used words and return the results in the output fields. 
##
## It consists of four functions to process the inputs: 
## (1) extractwords 
## (2) countWords 
## (3) countChars
## (4) findtop10

## extractwords
## This function extracts words from the input text. 
##
## It uses a space to separate each word. Multiple spaces and carriage return will be ignored. 
## It also remove the special characters such as period, comma, single quote, double quote, brackets, 
## question mark and exclation marks from the word. Note: The list of special characters is not 
## exhausted and can be improved. 
## 
## parameter: text - text to process
## return: a vector of the words extracted from the input text
#
extractWords <- function(text) {
    ## remove end of line and replace by space
    text <- gsub("[\r\n]", ' ', text)

    ## remove double spaces
    text <- gsub(' {2,}', ' ', text)
    
    ## remove special characters
    text <- gsub('[(]','',text)
    text <- gsub('[)]','',text)
    text <- gsub('[.]','',text)
    text <- gsub('[,]','',text)
    text <- gsub('[!]','',text)
    text <- gsub('[?]','',text)
    text <- gsub('[\']','',text)
    text <- gsub('[\"]','',text)
    text <- tolower(text)
    
    ## remove leading and trailing spaces
    text <- gsub("[ ]+$", "", text)
    text <- gsub("^[ ]+", "", text)
    
    ## split the text to each word, separated by spaces
    strsplit(text, ' ') 
}

## countWords
## This function counts the number of words from the input text. 
## 
## It simply uses extractwords function to extract words from the input text and do the count.
##
## parameter: text - text to process
## return: number of words in the input text
##
countWords <- function(text) {
    ## extract each word from the text
    words <- extractWords(text)
    
    ## get number of the words
    length(words[[1]])
}

## countChars
## This function counts the number of characters from the input text. 
## 
## It simply removes the carriange return from the text before finding the number of characters.
##
## parameter: text - text to process
## return: number of characters in the input text
##
countChars <- function(text) {
    ## remove carriage returns before count number of characters
    text <- gsub("[\r\n]", '', text)
    
    ## get the number of characers
    nchar(text)
}

## findtop10
## This function finds the top 10 frequently used words from the input text.
## 
## It will return the text "Not Avaialble" if input text is blank. It uses extractwords function to extract 
## words from input text first, then do the count and find the percentage. it will sort the result by the 
## count in descending order and return the first 10 rows.
##
## parameter: text - text to process
## return: a data frame of the top 10 words. The data frame contains 3 columns, Word, Count and Percentage.
##
findtop10 <- function(text) {
  if (text == "") 
     "Not Available"
  else {
    ## convert words to data frame
    words <- extractWords(text)
    df <- data.frame(words)
    
    # count each word occurance 
    counttable <- table(words)
    df <- data.frame(counttable)
    names(df) <- c("word", "count")
    
    ## create exta column to calculate the percentage of the occurences
    df <- cbind(df, paste(round((df$count/sum(df$count))*100,2),'%'))
    
    ## rename the columns
    colnames(df) <- c("Word", "Count", "Percent")
    
    ## order the data by count in descending order
    df <- arrange(df, desc(Count))
    
    ## get the top 10
    head(df, n=10)
  }
}

shinyServer(
  function(input, output) {
      output$wordscount <- renderText({paste("Words : ", countWords(input$inputText))})
      output$charscount <- renderText({paste("Characters : ", countChars(input$inputText))})
      output$top10 <- renderPrint({findtop10(input$inputText)})
  }
)
