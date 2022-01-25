
library(shiny)

shinyServer(function(input, output, session) {


  # Click -------------------------------------------------------------------
  val <- reactiveVal()
  observeEvent(input$button_hi, {
    val("Hi!")
  })
  observeEvent(input$button_hello, {
    val("Hello!")
  })
  output$greeting <- renderText({
    val()
  })

  # checkbox
  # observeEvent(input$checkbox, {
  #   updateCheckboxInput(session, "checkbox", value = !input$checkbox)
  # })
  output$checkboxvalue <- renderPrint(input$checkbox)

  # Focus -------------------------------------------------------------------
  output$text <- renderText({
    input$textfield
  })


  # Event -------------------------------------------------------------------
  observeEvent(input$plus, {
    golem::print_dev("plus")
    new_value <- input$number + 1
    updateNumericInput(session, "number", value = new_value)
  })
  # Substract
  observeEvent(input$minus, {
    golem::print_dev("minus")
    new_value <- input$number - 1
    updateNumericInput(session, "number", value = new_value)
  })


  # Radio  ------------------------------------------------------------------
  output$radio_value <- renderText({input$radios})


})
