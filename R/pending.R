#' Display a yellow dot to indicate this test is pending implementation.
#'
#' Note that the yellow dot allows easy use with the \code{"summary"}
#' reporter in the testthat package (see \code{testthat:::find_reporter}).
#' Using this function in a test also makes it explicitly clear that it
#' should be implemented shortly.
#'
#' @importFrom crayon yellow
#' @export
pending <- function() {
  cat(crayon::yellow('.'))
}
