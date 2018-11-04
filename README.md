
hpconf
======

[![GitHub Version](https://github.com/franzmohr/hpconf/releases)](https://github.com/franzmohr/hpconf/releases)) [![Build Status](https://travis-ci.org/franzmohr/hpconf.svg?branch=master)](https://travis-ci.org/franzmohr/hpconf)

Overview
--------

Provides a function for the calculation of confidence bands for the Hodrick-Prescott (HP) filter as proposed in Giles (2013).

*Note that the construction of such confidence bands is only reasonable for stationary times series.*

Installation
------------

``` r
# install.packages("devtools")
devtools::install_github("franzmohr/hpconf")
```

Usage
-----

The following code reproduces figures 3 and 4 in Giles (2013).

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

Giles, D. E. (2013). Constructing confidence bands for the Hodrick-Prescott filter. <em>Applied Economics Letters (20)</em>5, 480-484. <https://doi.org/10.1080/13504851.2012.714057>
