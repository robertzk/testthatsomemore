Extended Testing Framework for R
=========

Hadley's [testthat](https://github.com/hadley/testthat) revolutionized package development
in the R-sphere, but there are still some features lacking. `testthatsomemore` provides:

  * The ability to mock and stub functions and closures, including those in packages.
  * Creation of hierarchical file structures for testing of IO-related functions.

To use, simply run:

```r
if (!require(testthatsomemore)) {
  if (!require(devtools)) install.packages('devtools'); require(devtools)
  install_github('robertzk/testthatsomemore') 
}
```

and explicitly load `library(testthatsomemore)` before running unit tests with
`devtools::test`.

Examples
========

Stubbing
-------

To test certain functions in your package it may be required to "stub" away
some of the functionality to avoid unnecessary action. For example, when
testing a function that trains an algorithm over an extended period of time,
it would be helpful to skip the computationally expensive step and ensure
the rest of the code is working as expected. We can use testthatsomemore
in our tests as follows. Image we have a function as below.

```R
complicated_function <- function() {
  input <- something_simple()
  output <- something_long_and_complicated(input)
  something_else_simple(output)
}
```

We can then "stub" away the long and complicated sub-function so it
won't actually execute.

```R
context('your function')

test_that('it does what it's supposed to do', {
  stub(complicated_function, "something_long_and_complicated") <-
    function(...) "test"
  expect_identical(complicated_function(), something_else_simple("test"))
})
```

Mocking file structures
-----------


[![Build Status](https://travis-ci.org/robertzk/testthatsomemore.svg?branch=master)](https://travis-ci.org/robertzk/testthatsomemore.svg?branch=master)

