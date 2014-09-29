#' This package is intended as a companion to the testthat package with
#' additional support for:
#'
#'   - Stubbing methods
#'   - Verifying calls and returns
#'   - Tests involving the file system
#'
#' For example, when files need to be present for a function we are testing,
#' it would be very cumbersome to create these files manually. Instead
#' testthatsomemore offers helper functions to create a structured set of
#' files:
#'
#' \code{test_dir <- create_test_files(list(dir1 = list('file1',
#'    file2.r = 'print("Sample R code")'), file3.csv = "a,b,c\n1,2,3"))}
#'
#' with the return value being a test directory containing these structured files.
#' Additionally, \code{create_test_files} has created an \code{on.exit} trigger
#' in the calling environment that will unlink everything in this test directory.
#'
#' @docType package
#' @name testthatsomemore
#' @import testthat
NULL
