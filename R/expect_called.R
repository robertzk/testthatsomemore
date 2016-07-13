#' Expect that a function was called while executing an expression.
#'
#' @param fn function. The function that was expected to get called. If not
#'   specified with \code{::}, package_name param must be specified.
#' @param expr expression. The expression to execute.
#' @param package_name string. The package where fn lives. If not specified, fn must
#'   be package_name::fn.
#' @param was_called logical. If \code{FALSE}, negate the meaning: \code{fn}
#'   should \emph{not} have been called. By default \code{TRUE}.
#' @return invisible \code{TRUE}.
#' @examples \dontrun{
#'   expect_called(base::print, print("Hello")) # Will pass
#'   expect_called(print, print("Hello"), "base") # Will pass
#'   expect_called(base::print, cat("Hello")) # Will fail
#'   expect_called(base::print, cat("Hello"), was_called = FALSE) # Will pass
#' }
expect_called <- function(fn, expr, package_name, was_called = TRUE) {
  fn <- substitute(fn)
  if (is.call(fn) && identical(as.character(fn[[1]]), "not")) {
    fn       <- fn[[2]]
    was_called <- FALSE
  }
  # Turn foo into package_name::foo
  if (is.name(substitute(fn))) fn <- bquote(getFromNamespace(.(deparse(fn)), .(package_name)))
  else fn <- as.call(list(quote(getFromNamespace), as.character(fn[[3]]), as.character(fn[[2]])))

  grab <- function(i) as.character(as.list(fn)[[i]])

  copy_of_fn <- duplicate(eval(fn))
  env <- list2env(list(called = 0), parent = emptyenv())

  mocked_fn <- function(...) {
    env$called <- env$called + 1
    copy_of_fn(...)
  }

  result <- testthatsomemore::package_stub(grab(3), grab(2), mocked_fn, force(expr))
  expect_identical(was_called, as.logical(env$called))

  invisible(TRUE)
}

