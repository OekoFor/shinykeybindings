
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {


    # Click -------------------------------------------------------------------
    # Add
    observeEvent(input$add, {
        new_value <- input$number + 1
        updateNumericInput(session, "number", value = new_value)
    })
    # Substract
    observeEvent(input$substract, {
        new_value <- input$number - 1
        updateNumericInput(session, "number", value = new_value)
    })

})
