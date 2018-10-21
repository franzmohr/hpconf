
hpconf
======

Overview
--------

Provides a function for the calculation of confidence bands for the Hodrick-Prescott filter.

Installation
------------

``` r
# install.packages("devtools")
devtools::install_github("franzmohr/hpconf")
```

Usage
-----

``` r
library(mFilter)
library(hpconf)

data("unemp")

hp_unemp <- hpfilter(unemp)
hp_conf <- hpconf(hp_unemp)

plot(hp_conf, ylab = "unemp",
     plot.type = "single", col = c("blue", "red", "red", "black"))
```

<img src="README_files/figure-markdown_github/intervals-1.png" style="display: block; margin: auto;" />

References
----------

Giles, D. E. (2013). Constructing confidence bands for the Hodrick-Prescott filter, *Applied Economics Letters (20)*5, 480--484. <a href="https://doi.org/10.1080/13504851.2012.714057" target="_blank">10.1080/13504851.2012.714057</a>
