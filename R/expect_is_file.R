#' Return an error if a string represents an existent file.
#'
#' @param potential_filepath character. The name of the file path to check.
#' @param ... additional arguments to pass to \code{expect_true}.
#' @export 
#' @return TRUE or FALSE according as \code{potential_filepath} is or is not
#'   a file.
#' @examples
#' library(testthat)
#' # expect_error(expect_is_file('not/a/file')) # will error
#' tmp <- tempfile(); writeLines('', tmp)
#' expect_is_file(tmp) # will not error
expect_is_file <- function(potential_filepath, ...) {
  expect_true(is.character(potential_filepath) &&
              length(potential_filepath) == 1 &&
              file.exists(potential_filepath), ...)
}

#' Return an error if a string represents an existent directory.
#'
#' @rdname expect_is_file
#' @export 
#' @return TRUE or FALSE according as \code{potential_path} is or is not
#'   a directory. 
#' @examples
#' \dontrun{
#' # expect_is_directory('not/a/dir') # will error
#' expect_is_directory(dirname(tempfile())) # will not error
#' }
expect_is_directory <- function(potential_filepath, ...) {
  expect_true(is.character(potential_filepath) &&
              length(potential_filepath) == 1 &&
              file.exists(potential_filepath) &&
              file.info(potential_filepath)$isdir, ...)
}

