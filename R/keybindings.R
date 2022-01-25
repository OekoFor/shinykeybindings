#' Keybindings for Shiny Widgets
#'
#' @description
#' This will be the description of all functions
#' @param inputId inputID of the widget you want to click on
#' @param key the keyvalue e.g. "a". See Details
#' @param modifier Modifier Key. Allowed values are "ctrl", "alt" (option or ⌥ on OS X) or "shift". Only one modifier is allowed.
#' @name keybindings
#' @details
#' NOTE: Your keybindings may conflict with default shortcuts from your browser e.g. \code{ctrl + `+`} to magnify the page. \pkg{shinykeybindings} will prevent this and will only listen to your custom keybindings
#' Other common keys you might want to use besides the usal alphanumerical keys:
#' - 'Enter' for '\code{'Enter'}, \code{'↵'} or \code{'Return'}
#'
#' https://jsfiddle.net/4j54jqt2/4
#'
#' @import shiny
#' @import glue
#'
#' @examples
#' \dontrun{
#' kb_examples()
#' }
NULL
#> NULL

#' @rdname keybindings
#' @export
kb_click <-
  function(inputId,
           key = NULL,
           modifier = NULL) {
    keypress_js_condition <- key_args_to_js_condition(key, modifier)
    js <-
      glue::glue(
        "document.addEventListener('keydown', function (event) {
          if (<<keypress_js_condition>>) {
             event.preventDefault();
             $('#<<inputId>>').click();
          }
        });",
        .open = "<<",
        .close = ">>"
      )
    tags$script(HTML(js))
  }

#' @rdname keybindings
#' @export
kb_focus <- function(inputId,
                     key = NULL,
                     modifier = NULL) {
  keypress_js_condition <- key_args_to_js_condition(key, modifier)
  js <-
    glue::glue(
      "document.addEventListener('keydown', function (event) {
        if (<<keypress_js_condition>>) {
           event.preventDefault();
           $('#<<inputId>>').focus();
        }
      });",
      .open = "<<",
      .close = ">>"
    )
  tags$script(HTML(js))
}

#' @rdname keybindings
#' @export
# Creates Shiny Input that can be used to trigger observeEvent
kb_event <- function(inputId,
                     key = NULL,
                     modifier = NULL) {
  keypress_js_condition <- key_args_to_js_condition(key, modifier)
  js <-
    glue::glue(
      "document.addEventListener('keydown', function (event) {
        if (<<keypress_js_condition>>) {
           event.preventDefault();
           Shiny.onInputChange('<<inputId>>', Math.random());
        }
      });",
      .open = "<<",
      .close = ">>"
    )
  tags$script(HTML(js))
}

#' @rdname keybindings
#' @export
kb_radio <- function(inputId,
                             key = NULL,
                             modifier = NULL,
                             value = NULL) {
  if (is.null(value)) warning("Function argument 'value' is empty with no default")

  keypress_js_condition <- key_args_to_js_condition(key, modifier)
  js <-
    glue::glue(
      "document.addEventListener('keydown', function (event) {
        if (<<keypress_js_condition>>) {
           event.preventDefault();
           var $radioButtons = $('input:radio[name = <<inputId>>]');
           $radioButtons.filter('[value = <<value>>]').prop('checked', true);
           Shiny.setInputValue('<<inputId>>', '<<value>>');
        }
      });",
      .open = "<<",
      .close = ">>"
    )
  tags$script(HTML(js))
}
