context("Load maps")
library(rmapdata); library(testthat); library(dplyr)

test_that("All maps load correctly", {

  mapx <- rmapdata::map(rmapdata::mapUS49, show = F, save=F)
  tVal1 <- length(mapx)
  testthat::expect_gt(tVal1,0)
})
