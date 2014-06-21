Extended Testing Framework for R
=========

Hadley's [testthat](https://github.com/hadley/testthat) revolutionized package development
in the R-sphere, but there are still some features lacking. `testthatsomemore` provides:

  * The ability to mock and stub functions and closures.
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

[![Build Status](https://travis-ci.org/robertzk/testthatsomemore.svg?branch=master)](https://travis-ci.org/robertzk/testthatsomemore.svg?branch=master)
