
<!-- README.md is generated from README.Rmd. Please edit that file -->

# shinykeybindings

<!-- badges: start -->
<!-- badges: end -->

Set keybindings that allow you to navigate your Shiny App using keyboard
shortcuts. Perform clicking actions, focus widgets, trigger reactivity
or set values of radio buttons, all from your keyboard!

## Installation

You can install the latest released version of shinykeybindings from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("OekoFor/shinykeybindings@*release")
```

## Example

This minimal example adds the keyboard shortcut **ctrl + Enter** to the
example app of `shiny::actionButton()`

``` r
library(shinykeybindings)
## Only run examples in interactive R sessions
if (interactive()) {

ui <- fluidPage(
  sliderInput("obs", "Number of observations", 0, 1000, 500),
  actionButton("goButton", "Go!", class = "btn-success"),
  plotOutput("distPlot"),
  
  #keybinding
  kb_click("goButton", key = "Enter", modifier = "ctrl")
)

server <- function(input, output) {
  output$distPlot <- renderPlot({
    # Take a dependency on input$goButton. This will run once initially,
    # because the value changes from NULL to 0.
    input$goButton

    # Use isolate() to avoid dependency on input$obs
    dist <- isolate(rnorm(input$obs))
    hist(dist)
  })
}

shinyApp(ui, server)

}
```