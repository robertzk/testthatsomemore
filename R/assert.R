#' Explicitly state that we expect no errors to occur.
#'
#' Note we could simply write the expression itself and let it error,
#' but using \code{assert} makes the intention of the code clearer 
#' (like using \code{base::force}).
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

