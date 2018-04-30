#' Confidence Bands for the Hodrick-Prescott Filter
#'
#' Constructs confidence bands for the Hodrick-Prescott filter
#'
#' @param data an object of class "mFilter" containing the output of the function \code{hpfilter}.
#' @param V_y a numeric specifying the variance of the cyclical component. If \code{V_y = NULL} (default),
#' the sample variance of the cyclical component will be used.
#' @param ci numeric between 0 and 1 specifying the confidence interval, defaults to 0.05.
#'
#' @source Giles, D. E. (2012) Constructing Confidence Bands for the Hodrick-Prescott Filter. Econometrics Working Papers 1202, University of Victoria.
#'
#' @export
hpconf <- function(data, V_y = NULL, ci = .05) {
  if(!requireNamespace("mFilter")){
    stop("This packages requires the 'mFilter' package.")
  }

  if (class(data) != "mFilter") {
    stop("Class of data must be 'mFilter'.")
  }

  if (data$title != "Hodrick-Prescott Filter") {
    stop("Object data must contain the output of the function mFilter::hpfilter.")
  }

  t <- length(data$cycle)
  lambda <- data$lambda
  cycle <- data$cycle
  trend <- data$trend
  y <- data$x
  Q <- diag(1, t) - data$fmatrix

  if (is.null(V_y)) {
    V_y <- stats::var(cycle) * diag(1, t)
  }

  V_t <- Q %*% V_y %*% Q
  se <- matrix(sqrt(diag(V_t)))
  ci <- stats::qnorm(1 - ci /2)
  ci_low <- trend - ci * se
  ci_high <- trend + ci * se

  return(cbind(trend, ci_low, ci_high, y))
}
