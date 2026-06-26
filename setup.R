#!/usr/bin/env Rscript
packages <- c("rpart.plot", "tidymodels", "vip")
install.packages(packages[!packages %in% installed.packages()[,"Package"]])
