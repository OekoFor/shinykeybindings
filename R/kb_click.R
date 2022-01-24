#' Keybinding for 'click' actions
#'
#'https://jsfiddle.net/4j54jqt2/4
#'
#' @param inputId inputID of the wdget you want to click on
#' @param key keycode
#'
#' @export
#' @import shiny
#' @import glue
#'
#' @examples
#' ## Only run examples in interactive R sessions
## Only run examples in interactive R sessions
#' if (interactive()) {
#'   # options(device.ask.default = FALSE)
#'
#'   ui <- fluidPage(
#'     h3("click keyboardbinding"),
#'     p("Add", strong(1), "by clicking", code("+"), "or hit the", code("spacebar")),
#'     p("Substract", strong(1), "by clicking", code("-"), "or hit", code("ctrl + spacebar")),
#'
#'     actionButton("add", NULL, icon = icon("plus")),
#'     actionButton("substract", NULL, icon = icon("minus")),
#'     numericInput("number", NULL, value = 10),
#'
#'     kb_click("add", 32),
#'     kb_click("substract", 77)
#'   )
#'
#'   # Server logic
#'   server <- function(input, output, session) {
#'
#'     # Add 1
#'     observeEvent(input$add, {
#'       new_value <- input$number + 1
#'       updateNumericInput(session, "number", value = new_value)
#'     })
#'
#'     # Substract 1
#'     observeEvent(input$substract, {
#'       new_value <- input$number - 1
#'       updateNumericInput(session, "number", value = new_value)
#'     })
#'   }
#'
#'   # Complete app with UI and server components
#'   shinyApp(ui, server)
#' }
#'
# kb_click <- function(inputId, key) {
#   js_stuff <- paste0("$(function(){
#       $(document).keyup(function(e) {
#       if (e.which == ", key, ") {
#         $('#", inputId, "').click()
#       }
#       });
#       })")
#   tags$script(HTML(js_stuff))
# }
kb_click <- function(inputId, key) {
  js <-
    glue::glue(
      "$(function() {
        $(document).keyup(function(e) {
          if (e.which == <<key>>) {
            $('#<<inputId>>').click();
          }
        });
      });",
      .open = "<<", .close = ">>"
    )
  tags$script(HTML(js))
}


new_click <- function(inputId, key, modifier = NULL) {

  if (!is.null(modifier)) {
    modkey <- glue::glue("event.{modifier}Key && ")
  } else {
    modkey = ''
  }

  keys_down_str <- glue::glue("{modkey}event.key === '{key}'")
  js <-
    glue::glue(
      "document.addEventListener('keyup', function (event) {
        if (<<keys_down_str>>) {
           $('#<<inputId>>').click();
        }
      });",
      .open = "<<", .close = ">>"
    )
  tags$script(HTML(js))
}





key <- c("y")
inputId <- "add"
code <- new_click("bla", "y")

code <- glue::glue(
  "document.addEventListener('keyup', function (event) {
        if (event.ctrlKey && event.key === '<<key>>') {
           $('#<<inputId>>').click();
        }
      });",
  .open = "<<", .close = ">>"
)


jshint(code)
cat(uglify_reformat(code, beautify = TRUE, indent_level = 2))

