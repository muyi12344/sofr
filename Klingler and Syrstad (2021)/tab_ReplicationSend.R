rm(list = ls())
WORK.DIR = "/Users/mac/Desktop/Research/sofr/Klingler and Syrstad (2021)"
setwd(WORK.DIR)

library(MASS)
library(cowplot)
library(ggplot2)
library(LaplacesDemon)
library(coda)
library(xtable)
library(dplyr)
library(stargazer)
library(haven)
library(data.table)
library(AER)
library(stringr)
library(stringi)
library(tigris)
library(reshape2)
library(lubridate)
library(tidyverse)
library(lfe)

D = fread('ReplicateDaily.csv')
D2 = fread('ReplicateWeekly.csv')

source(paste0(which_WD, '/functions/fct_FirstDiff.R'))
d = D[D.Include == 1,.(Spread = diff(Spread), debt = diff(debt), SOFRV = diff(SOFRV))]
d2 = D2[D.Include == 1,.(Spread = diff(Spread), debt = diff(debt), SOFRV = diff(SOFRV), Reserves = diff(Reserves))]

summary(felm(Spread ~ debt + SOFRV, d), robust = T)
summary(felm(Spread ~ debt + SOFRV + Reserves, d2), robust = T)
