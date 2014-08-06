`%||%` <- function(x, y) if (is.null(x)) y else x

#' @export
is.directory <- function(x) file.exists(x) && file.info(x)$isdir

#' Touch a file.
#'
#' Using the touch helper on a Unix system.
#'
#' @param filename character. The file to touch.
#' @export
touch <- function(filename) {
  system(paste('touch', filename))
}

