
#' make js condition
#'
#' only for internal use
#' @inheritParams kb_click
key_args_to_js_condition <- function(key, modifier) {
  if (is.null(key)) stop("Function argument 'key' is empty with no default")
  if (!is.null(modifier)) {
    if (!modifier %in% c(NULL, "ctrl", "alt", "shift")) stop("unknown modifier")
  }
  if (!is.null(modifier)) {
    modkey <- glue::glue("event.{modifier}Key && ")
  } else {
    modkey <- ""
  }
  glue::glue("{modkey}event.key === '{key}'")
}
