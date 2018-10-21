#' Plot HP-Filter Confidence Bands
#' 
#' A plot function for objects of class "hpconf".
#' 
#' @param x an object of class "hpconf", usually, a result of a call to \code{\link{hpconf}}.
#' @param ... further graphical parameters.
#' 
#' @export
plot.hpconf <- function(x, ...) {
  stats::plot.ts(x, plot.type = "single", col = c("blue", "red", "red", "black"), ...)
}