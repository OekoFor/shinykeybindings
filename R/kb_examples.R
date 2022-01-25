#' Run Examples App
#'
#' Run a ShinyApp and explore the functionality of \pkg{shinykeybindings}
#'
#' @export
kb_examples <- function() {
  appDir <- system.file("shinyexamples", "kb_examples", package = "shinykeybindings")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `mypackage`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "showcase", launch.browser = TRUE)
}
