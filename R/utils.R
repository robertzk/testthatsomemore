`%||%` <- function(x, y) if (is.null(x)) y else x

#' @export
is.directory <- function(x) file.exists(x) && file.info(x)$isdir

