#' Stub the environment of a closure.
#'
#' When testing functions, sometimes we would like to not use certain
#' downstream methods that get called by that function. For example, if
#' we are testing an HTTP library, we may not want to make actual HTTP calls.
#' We can "stub" away the functions in our main function so they perform
#' a less complex but functionally similar behavior. 
#'
#' @param fn function. The function to stub.
#' @param key character. The variable/key in the closure to stub away. One
#'    can also specify the name (without quoting it, using non-standard
#'    evaluation).
#' @param value ANY. The new value of the stubbed key.
#' @examples
#' fn <- function() { cat(paste0('a', 'b')) }
#' stub(fn, 'paste0') <- function(...) base::paste(...)
#' fn() # Will print "a b" instead of "ab"
#' stub(fn, paste0) <- function(...) base::paste(...) # This also works.
`stub<-` <- function(fn, key, value) {
  environment(fn) <- new.env(parent = environment(fn)) 
  # If key is a string, use that, otherwise deparse and substitute.
  key <- 
    if (is.element(substring(tmp <- deparse(substitute(key)), 1, 1), c("'", '"'))) key
    else tmp
  assign(key, value, envir = environment(fn))
  fn
}

