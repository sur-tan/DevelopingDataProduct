library(shiny)

## Word Counter UI
##
## This is the UI of the shiny application to count the number of words and characters of a text.
## User can simply enter the text in the input box and click 'Count' button.
## It will display the number of words, the number of characters and the top 10 words most 
## frequently used and the percentage each word is used within the text.
##
## The UI consists of a main panel on the left for the user's inputs and the side panel on the right
## to display the result. 

shinyUI(fluidPage(
  titlePanel("Word Counter"),
  
  sidebarLayout(
      position = "right",
      
      ## side panel to display the result
      sidebarPanel(
        h4("Summary"),
        textOutput('wordscount'), 
        textOutput('charscount'),
        br(),
        h5("Top 10 Words"),
        verbatimTextOutput('top10')
      ),
      
      ## main panel for user's inputs and display the help text
      mainPanel(
        helpText("Type or paste your text in the box below, then click 'Count' button"),
        tags$textarea(id="inputText", rows=10, style="width:100%"),
        br(),
        br(),
        submitButton("Count"),
        br(),
        
        helpText("Word Counter is function to count number of words and characters. 
                 Simply type in the box on the left panel and click the 'Count' button. 
                 Word counter will display the results on the right panel. 
                 You can also copy and paste the text in the box."
                 , align="justify"),

        helpText("In addition, Word Counter will also show the top 10 words most frequently 
                  used and the percentage each word is used within the text."
                 , align="justify")
      )
  )
))