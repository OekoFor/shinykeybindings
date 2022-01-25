library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  verticalLayout(
    fluid = FALSE,
    tagList(
      h3("Click"),
      splitLayout(
        cellWidths = "25%",
        wellPanel(
          strong("Click button or press key combination"),
          p(strong("Hello: "), code("Enter")),
          p(strong("Hi: "), code("ctrl + Enter")),

          actionButton("button_hi", "Hi!"),
          actionButton("button_hello", "Hello!"),
          textOutput("greeting"),

          # keybindings
          kb_click("button_hi", key = "Enter"),
          kb_click("button_hello", key = "Enter", modifier = "ctrl")
        ),
        wellPanel(
          strong("Check the box"),
          p(code("ctrl + m")),

          checkboxInput("checkbox", "checkbox"),
          verbatimTextOutput("checkboxvalue"),

          # keybindings
          kb_click("checkbox", "m", "ctrl")
        )
      )
    )
  ),
  tagList(
    h3("Focus"),
    splitLayout(
      cellWidths = "25%",
      wellPanel(
        style = "word-break: break-all;",
        strong("Press key combination to\nfocus the textfield"),
        p(code("str + t")),

        textInput("textfield", "Text Input", placeholder = "Hi there!"),
        textOutput("text"),

        # keybindings
        kb_focus("textfield", key = "m", modifier = "ctrl")
      )
    )
  ),
  tagList(
    h3("Event"),
    splitLayout(
      cellWidths = "25%",
      wellPanel(
        strong("Press key combination to trigger an event
               with no explicit UI-Element"),
        p(code("str + `+`"), "or", code("str + `-`")),

        numericInput("number", NULL, value = 10),

        # keybindings
        # NOTE: There is no UI-Widget with the respective inputIDs.
        # This is because kb_event will be used as an input e.g. input$plus to trigger a reactive
        kb_event("plus", key = "+", modifier = "ctrl"),
        kb_event("minus", key = "-", modifier = "ctrl")
      )
    )
  ),
  tagList(
    h3("Radio Buttons"),
    splitLayout(
      cellWidths = "25%",
      wellPanel(
        strong("Change radio button value"),
        p(code("alt + a/b/c")),

        radioButtons("radios", label = NULL, choices = c("A", "B", "C"), inline = TRUE),
        textOutput("radio_value"),

        # keybindings
        kb_radio("radios", key = "a", modifier = "alt", value = "A"),
        kb_radio("radios", key = "b", modifier = "alt", value = "B"),
        kb_radio("radios", key = "c", modifier = "alt", value = "C"),
      )
    )
  )
))
