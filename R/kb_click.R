#' Keybinding for 'click' actions
#'
#'https://jsfiddle.net/4j54jqt2/4
#'
#' @param inputId inputID of the widget you want to click on
#' @param key keycode
#'
#' @export
#' @import shiny
#' @import glue
#'
#' @examples
#' shinykeybindings::kb_examples()

kb_click <-
  function(inputId,
           key,
           modifier = NULL,
           plainJS = FALSE) {
    if (!is.null(modifier)) {
      modkey <- glue::glue("event.{modifier}Key && ")
    } else {
      modkey = ''
    }

    keys_down_str <- glue::glue("{modkey}event.key === '{key}'")

    js <-
      glue::glue(
        "document.addEventListener('keydown', function (event) {
        if (<<keys_down_str>>) {
           $('#<<inputId>>').click();
        }
      });",
      .open = "<<",
      .close = ">>"
      )
    if (plainJS) {
      js
    } else {
      tags$script(HTML(js))
    }
  }

#
# code <- new_click("bla", "y", modifier = "ctrl", plainHTML = TRUE)
# code
# js::jshint(code)
# cat(js::uglify_reformat(code, beautify = TRUE, indent_level = 2))
#
