#' Duplicate a function. Returns a carbon copy of the original, so that original
#' can be modified safely.
#'
#' @examples
#' \dontrun{
#'    fn <- function(x) cat(x, "\n")
#'    fn2 <- duplicate(fn)
#'    fn <- function(x) cat(x, "woof","\n")
#'    fn("hello") # hellowoof
#'    fn2("hello") # hello
#' }
#' @export
#' @useDynLib testthatsomemore duplicate_testthatsomemore_
duplicate <- function(x) {
  .Call(duplicate_testthatsomemore_, x)
}