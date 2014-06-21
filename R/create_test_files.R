#' Create a file structure for tests.
#'
#' A helper function for creating hierarchical file structures
#' when, e.g., testing functions which rely on presence of files.
#'
#' For example, when files need to be present for a function we are testing,
#' it would be very cumbersome to create these files manually. Instead, we can
#' do the following:
#'
#' \code{test_dir <- create_test_files(list(dir1 = list('file1',
#'    file2.r = 'print("Sample R code")'), file3.csv = "a,b,c\n1,2,3"))}
#'
#' with the return value being a test directory containing these structured files.
#' Additionally, \code{create_test_files} has created an \code{on.exit} trigger
#' in the calling environment that will unlink everything in this test directory.
#'
#' @param files list. A nested file structure. The names of the list will decide
#'    the names of the files, and the terminal nodes should be strings which
#'    will populate the file bodies.
#' @param dir character. The directory in which to create the files. If
#'    missing, a temporary directory will be created instead using
#'    the built-in \code{tempfile()} helper.
#' @return the directory in which this file structure exists.
#' @examples
#' \dontrun{
#'   test_dir <- create_test_files(list(test = 'blah', 'test2'))
#'   # Now test_dir is the location of a directory containing a file 'test'
#'   # with the string 'blah' and an empty file 'test2'.
#'
#'   test_dir <- create_test_files(list(alphabet = as.list(LETTERS)))
#'   # Now test_dir is the location of a directory containing a subdirectory
#'   # 'alphabet' with the files 'A', 'B', ..., 'Z' (all empty).
#' }
create_test_files <- function(files, dir) {
  files <- as.list(files)

  if (missing(dir)) {
    dir <- tempfile() 
    unlink(dir)
  }
  stopifnot(is.character(dir))
  dir.create(dir, showWarnings = FALSE, recursive = TRUE)

  lapply(seq_along(files), function(i) {
    name_is_blank <- function(x) !(is.character(x) && length(x) == 1 && !is.na(x))
    if (name_is_blank(name <- names(files)[i]) && !is.character(files[[i]])) {
      stop("You must either provide a filename as the name of a list element, ",
           "or a character list element itself.")
    }

    if (name_is_blank(name)) { name <- files[[i]]; body <- '' }
    else body <- files[[i]]

    if (!any(sapply(c('list', 'NULL', 'character'), is, object = body))) {
      stop("Only NULL, character, or list values are allowed in the nested list.")
    }

    if (is.list(body)) {
      dir.create(subdir <- file.path(dir, name),
                 showWarnings = FALSE, recursive = TRUE)
      create_test_files(body, subdir)
    } else writeLines(body %||% '', file.path(dir, name))
  })

  dir
}

