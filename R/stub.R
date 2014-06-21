#' Stub the environment of a closure.
#'
#' When testing functions, sometimes we would like to not use certain
#' downstream methods that get called by that function. For example, if
#' we are testing an HTTP library, we may not want to make actual HTTP calls.
#' We can "stub" away the functions in our main function so they perform
#' a less complex but functionally similar behavior. 
#'
#' @param fn function. The function to stub.
#' @param key function. The variable/key in the closure to stub away.
#' @param value ANY. The new value of the stubbed key.
#' @examples
#' fn <- function() { cat(paste0('a', 'b')) }
#' stub(fn, 'paste0') <- function(...) base::paste(...)
#' fn() # Will print "a b" instead of "ab"
`stub<-` <- function(fn, key, value) {
  environment(fn) <- new.env(parent = environment(fn)) 
  assign(key, value, envir = environment(fn))
  fn
}

