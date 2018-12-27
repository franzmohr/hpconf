#' Confidence Bands for the Hodrick-Prescott Filter
#'
#' A function for the calculation of confidence bands for the trend component of the Hodrick-Prescott (HP) filter as proposed by Giles (2013).
#'
#' @param data an object of class "mFilter" containing the output of the function \code{\link[mFilter]{hpfilter}}.
#' @param V_y a numeric specifying the variance of the cyclical component. If \code{V_y = NULL} (default),
#' the sample variance of the original time series will be used.
#' @param ci numeric between 0 and 1 specifying the confidence interval. Defaults to 0.95.
#' 
#' @details The function uses the filter matrix \eqn{F} from an "mFilter" object to obtain the matrix \eqn{Q = \left[I_T + \lambda K' K]^{-1}\right]}.
#' Since \eqn{Q y} provides an estimate of the trend \eqn{\hat{tau}} and \eqn{F y} yields the cyclical component of the process \eqn{\hat{c}} and the
#' time series \eqn{y} is decomposed only into those two components so that \eqn{y = \hat{tau} + \hat{c}},
#' \eqn{Q} can be obtained from \eqn{I_T y - Fy = Q y} so that \eqn{Q = I_T - F}.
#' 
#' The confidence band is then derived from the covariance matrix \eqn{V(\hat{tau}) = Q V(y) Q}.
#' 
#' By default \code{V_y = NULL} so that the sample variance of the original time series
#' is used for the construction of \eqn{V(y)}. This can be chanced by providing
#' a numeric value, for example from the output of an esitmated ARIMA model.
#' 
#' @return A time-series object of four variables
#' \itemize{
#'  \item \strong{trend:} The estimated trend component
#'  \item \strong{ci_lower:} The lower bound of the confidence band
#'  \item \strong{ci_upper:} The upper bound of the confidence band
#'  \item \strong{y:} The actual series
#' }
#' 
#' @examples
#' library(mFilter)
#' library(hpconf)
#' 
#' # Load data
#' data("unemp")
#' 
#' # Run HP-filter
#' hp_unemp <- hpfilter(unemp)
#' 
#' # Obtain confidence bands
#' hp_conf <- hpconf(hp_unemp)
#' 
#' # Plot
#' plot(hp_conf)
#' 
#' @references
#' 
#' Giles, D. E. (2013). Constructing confidence bands for the Hodrick-Prescott filter. \emph{Applied Economics Letters}, 20(5), 480--484. \url{https://doi.org/10.1080/13504851.2012.714057}
#'
#' @export
hpconf <- function(data, V_y = NULL, ci = .95) {
  if(!requireNamespace("mFilter")){
    stop("This packages requires the 'mFilter' package.")
  }

  if (class(data) != "mFilter") {
    stop("Class of object 'data' must be 'mFilter'.")
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
    V_y <- c(stats::var(y)) * diag(1, t)
  } else {
    V_y <- V_y * diag(1, t)
  }

  V_t <- Q %*% V_y %*% Q
  se <- matrix(sqrt(diag(V_t)))
  ci <- 1 - ci
  ci <- stats::qnorm(1 - ci / 2)
  ci_low <- trend - ci * se
  ci_high <- trend + ci * se

  result <- cbind(trend, ci_low, ci_high, y)
  class(result) <- append("hpconf", class(result))
  return(result)
}
