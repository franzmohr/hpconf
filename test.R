rm(list = ls())

devtools::load_all(".")

library(dplyr)
library(mFilter)

data(unemp)

unemp.hp <- hpfilter(unemp)
plot(unemp.hp)

unemp.conf <- hpconf(unemp.hp)
plot(unemp.conf, plot.type = "single")

#' library(mFilter)
#' data(unemp)
#'
#' unemp.hp <- hpfilter(unemp)
#' plot(unemp.hp)
#'
#' unemp.conf <- hpconf(unemp.hp)
#' plot(unemp.conf, plot.type = "single")
