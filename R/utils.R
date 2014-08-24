`%||%` <- function(x, y) if (is.null(x)) y else x

#' Check whether a path is a directory.
#'
#' @param path character. The name of the path.
#' @export
is.directory <- function(path) file.exists(path) && file.info(path)$isdir

#' Touch a file.
#'
#' Using the touch helper on a Unix system.
#'
#' @param filename character. The file to touch.
#' @export
touch <- function(filename) {
  system(paste('touch', filename))
}

