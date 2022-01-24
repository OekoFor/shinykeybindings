#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    h3("click keyboardbinding"),
    p(
        "Add",
        strong(1),
        "by clicking",
        code("+"),
        "or hit the",
        code("spacebar")
    ),
    p(
        "Substract",
        strong(1),
        "by clicking",
        code("-"),
        "or hit",
        code("ctrl + spacebar")
    ),

    actionButton("add", NULL, icon = icon("plus")),
    actionButton("substract", NULL, icon = icon("minus")),
    numericInput("number", NULL, value = 10),

    kb_click("add", key = " "),
    kb_click("substract", key = " ", modifier = "ctrl")
))
