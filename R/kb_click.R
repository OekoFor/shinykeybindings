#' Keybindings for Shiny Widgets
#'
#' @description
#'
#' @param inputId inputID of the widget you want to click on
#' @param key the keyvalue e.g. "a". See Details
#' @param modifier Modifier Key. Allowed values are "ctrl", "alt" (option or ⌥ on OS X) or "shift". Only one modifier is allowed.
#'
#' @details
#' Other common keys you might want to use besides the usal alphanumerical keys:
#' - 'Enter' for '\code{'Enter'}, \code{'↵'} or \code{'Return'}
#'
#' https://jsfiddle.net/4j54jqt2/4
#'
#' @export
#' @import shiny
#' @import glue
#'
#' @examples
#' \dontrun{shinykeybindings::kb_examples()}

kb_click <-
  function(inputId,
           key = NULL,
           modifier = NULL) {
    keypress_js_condition <- key_args_to_js_condition(key, modifier)
    js <-
      glue::glue(
        "document.addEventListener('keydown', function (event) {
        if (<<keypress_js_condition>>) {
           $('#<<inputId>>').click();
        }
      });",
      .open = "<<",
      .close = ">>"
      )
    tags$script(HTML(js))
  }

#' @describeIn kb_click Focus on a widget
kb_focus <- function(inputId,
                     key = NULL,
                     modifier = NULL) {
  keypress_js_condition <- key_args_to_js_condition(key, modifier)
  js <-
    glue::glue(
      "document.addEventListener('keydown', function (event) {
        if (<<keypress_js_condition>>) {
           $('#<<inputId>>').focus();
        }
      });",
      .open = "<<",
      .close = ">>"
    )
  tags$script(HTML(js))
}
