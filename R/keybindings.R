#' Keybindings for Shiny Widgets
#'
#' @description
#' ### \emph{\strong{Overview of keybinding functions:}}
#' The keybinding functions set keyboard shortcuts to allow interactions with different shiny widgets without using the mouse pointer.\cr
#' They mainly provide wrappers around different javascript actions and may sometimes be used interchangeably.\cr
#' Common usage is:
#' \itemize{
#'   \item \strong{kb_click():} Shortcut will perform a click action. Usually used with \code{\link[shiny]{actionButton}} or \code{\link[shiny]{checkbox}}
#'   \item \strong{kb_event():} Creates a Shiny Input that can be used to trigger a reactive e.g. \code{\link[shiny]{observeEvent}}. Does not need a UI-element.
#'   \item \strong{kb_focus():} Shortcut focuses a widget, usually a \code{\link[shiny]{textInput}} or \code{\link[shiny]{selectInput}}. See Details for more use cases.
#'   \item \strong{kb_radio():} Shortcut sets the value of \code{\link[shiny]{radioButtons}}. Needs one keybinding per value. See Details for an alternative approach.
#' }
#'
#' @param inputId inputID of the widget you want to click on
#' @param key the keyvalue e.g. "a". Mostly just whatever the keypress produces.\cr Some special keys are:
#' \itemize{
#' \item \strong{Enter/Return key}: type \code{'Enter'}
#' \item \strong{Space Bar}: type a literal space \code{" "}
#' \item see this page for more key values\cr \url{https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key/Key_Values}
#' }
#' @param modifier Modifier Key. Allowed values are "ctrl", "alt" (option or ⌥ on OS X) or "shift". Only one modifier is allowed.
#' @name keybindings
#' @details
#' Almost all widgets can be focused using \code{kb_focus()}. Some widgets also allow to change values when focused using the arrow key. It is possible avoid \code{kb_radio()} by first focusing the widget and then using the arrow keys to toggle different choices.
#'
#'
#' NOTE: Your keybindings may conflict with default shortcuts from your browser e.g. \code{ctrl + `+`} to magnify the page. \pkg{shinykeybindings} will prevent this and will only listen to your custom keybindings
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
#' @param value the value (or choice) that will be selected
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
