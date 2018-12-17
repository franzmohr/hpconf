
hpconf
======

[![CRAN status](https://www.r-pkg.org/badges/version/hpconf)](https://cran.r-project.org/package=hpconf) [![Travis build status](https://travis-ci.org/franzmohr/hpconf.svg?branch=master)](https://travis-ci.org/franzmohr/hpconf)

Overview
--------

The package augments Mehmet Balcilar's [`mFilter`](https://CRAN.R-project.org/package=mFilter) package by providing a function for the calculation of confidence bands for the trend component of the two-sided Hodrick-Prescott (HP) filter as proposed by [Giles (2013)](https://doi.org/10.1080/13504851.2012.714057).

*Note that the construction of such confidence bands is recommended only for stationary times series.*

Installation
------------

### Development version

``` r
# install.packages("devtools")
devtools::install_github("franzmohr/hpconf")
```

Usage
-----

The following code reproduces figures 3 and 4 in Giles (2013) in one graph.

``` r
# Load packages
library(alfred)
library(mFilter)
library(hpconf)

# Download data
unemp <- get_fred_series(series_id = "LNS14100000", series_name = "value",
                         observation_start = "1968-01-01", observation_end = "2012-03-01")

# Transform data into time-series object
unemp <- ts(unemp$value, start = 1968, frequency = 12)

# HP-filter
hp_unemp <- hpfilter(unemp, freq = 14400)

# Obtain confidence bands
hp_unemp_conf <- hpconf(hp_unemp)

# Plot
plot(hp_unemp_conf, main = "US unemployment rate", ylab = "", xlab = "", ylim = c(0, 12))
```

<img src="README_files/figure-markdown_github/example 1-1.png" style="display: block; margin: auto;" />

References
----------

Balcilar, M. (2018). mFilter: Miscellaneous Time Series Filters. R package version 0.1-4. <https://CRAN.R-project.org/package=mFilter>

Giles, D. E. (2013). Constructing confidence bands for the Hodrick-Prescott filter. <em>Applied Economics Letters (20)</em>5, 480-484. <https://doi.org/10.1080/13504851.2012.714057>
