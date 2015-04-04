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
#' @param character.only logical. As with the \code{character.only}
#'    parameter of \code{base::library}, this will not use non-standard
#'    evaluation for \code{key} if set to \code{TRUE}. The default is
#'    \code{FALSE}.
#' @param value ANY. The new value of the stubbed key.
#' @export
#' @examples
#' fn <- function() { cat(paste0('a', 'b')) }
#' stub(fn, 'paste0') <- paste
#' fn() # Will print "a b" instead of "ab"
#' stub(fn, paste0) <- paste # This also works.
#'
#' stubbed_key <- 'paste0'
#' stub(fn, stubbed_key, character.only = TRUE) <- paste
#' # We need to use character.only = TRUE for the above meta-programming to work
`stub<-` <- function(fn, key, character.only = FALSE, value) {
  environment(fn) <- new.env(parent = environment(fn)) 
  # If key is a string, use that, otherwise deparse and substitute.
  key <- if (character.only || is.element(substring(tmp <-
    deparse(substitute(key)), 1, 1), c("'", '"'))) key else tmp
  assign(key, value, envir = environment(fn))
  fn
}

#' Stub a function in a package by replacing it with something else.
#'
#' Stubbing a function in a package can only be done in the context of
#' some expression (a block of code). Otherwise, dangerous things could happen!
#' (We are actually replacing the function in the package's namespace.)
#'
#' @param package_name character. The name of the package to look in.
#' @param function_name character. The name of the function to stub.
#' @param stubbed_value function. The function to temporarily replace this function with.
#' @param expr expression. An expression to evaluate with the stubbed changes.
#'   The stubbing will be reverted after this expression is executed.
#' @export
#' @examples
#' package_stub("methods", "new", function(...) 'test', stopifnot(new('example') == 'test')) 
package_stub <- function(package_name, function_name, stubbed_value, expr) {
  if (!is.element(package_name, utils::installed.packages()[,1]))
    stop(gettextf("Could not find package %s for stubbing %s",
                  sQuote(package_name), dQuote(function_name)))
  stopifnot(is.character(function_name))
  if (!is.function(stubbed_value))
    warning(gettextf("Stubbing %s::%s with a %s instead of a function",
            package_name, function_name, sQuote(class(stubbed_value)[1])))

  namespaces <-
    list(as.environment(paste0('package:', package_name)),
         getNamespace(package_name))
  if (!exists(function_name, envir = namespaces[[1]], inherits = FALSE))
    namespaces <- namespaces[-1]
  if (!exists(function_name, envir = tail(namespaces,1)[[1]], inherits = FALSE))
    stop(gettextf("Cannot stub %s::%s because it must exist in the package",
         package_name, function_name))

  lapply(namespaces, unlockBinding, sym = function_name)

  # Clean up our stubbing on exit
  previous_object <- get(function_name, envir = tail(namespaces,1)[[1]])
  on.exit({
    lapply(namespaces, function(ns) {
      tryCatch(error = function(.) NULL, assign(function_name, previous_object, envir = ns))
      lockBinding(function_name, ns)
    })
  })

  lapply(namespaces, function(ns)
    assign(function_name, stubbed_value, envir = ns))
  eval.parent(substitute(expr))
}

