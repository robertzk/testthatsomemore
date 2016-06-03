#' Explicitly state that we expect no errors to occur.
#'
#' Note we could simply write the expression itself and let it error,
#' but using \code{assert} makes the intention of the code clearer 
#' (like using \code{base::force}).
#'
#' For testing the converse, there already is \code{expect_error}.
#'
#' @param expr expression. This expression should not error.
#' @param ... additional arguments to \code{expect_false}, like \code{info}.
#' @export
#' @examples
#' assert(1 + 1) # This will throw no error.
#' # stopifnot(is(tryCatch(error = identity, assert(not_existent)), 'error'))
#' # The above will produce an error. In unit tests, it will be clear this
#' # means "We expect no error to occur."
assert <- function(expr, ...) {
  result <- tryCatch(error = identity, eval.parent(substitute(expr)))
  expect_false(is(result, 'error'), ...)
}


