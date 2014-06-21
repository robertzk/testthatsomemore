#' Explicitly state that we expect no errors to occur.
#'
#' @param expr expression. This expression should not error.
#' @param info character. The error message to display.
#' @export
assert <- function(expr, info) {
  result <- tryCatch(error = identity, eval.parent(substitute(expr)))
  if (is(result, 'error')) {
    if (missing(info)) stop(result)
    else stop(info)
  }
}

