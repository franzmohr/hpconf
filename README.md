# Confidence Bands for the Hodrick-Prescott Filter

## Overview
Provides a function for the calculation of confidence bands for the Hodrick-Prescott filter.

```r
library(mFilter)
library(hpconf)

data(unemp)

hp_unemp <- hpfilter(unemp)
hp_conf <- hpconf(hp_unemp)

plot(hp_conf, plot.type = "single", col = c("blue", "red", "red", "black"))
```

## Installation

The package is only available via GitHub:

```r
# install.packages("devtools")
devtools::install_github("franzmohr/hpconf")
```

## References
David E. Giles (2013) Constructing confidence bands for the Hodrick–Prescott filter, Applied Economics Letters, 20:5, 480-484, DOI: <a href="https://doi.org/10.1080/13504851.2012.714057" target="_blank">10.1080/13504851.2012.714057</a>
