rm(list = ls())
try(setwd('C:/Users/A1710046/Dropbox'), silent = T)
try(setwd('C:/Users/svkli/Dropbox'), silent = T)
which_WD = getwd()
source(paste0(getwd(),'/PhD/Rtools/getGoing.R'))
getGoing('/BuryingLibor')

wantTEX = F
require('lfe')

D = fread('ReplicateDaily.csv')
D2 = fread('ReplicateWeekly.csv')

source(paste0(which_WD, '/functions/fct_FirstDiff.R'))
d = D[D.Include == 1,.(Spread = diff(Spread), debt = diff(debt), SOFRV = diff(SOFRV))]
d2 = D2[D.Include == 1,.(Spread = diff(Spread), debt = diff(debt), SOFRV = diff(SOFRV), Reserves = diff(Reserves))]

summary(felm(Spread ~ debt + SOFRV, d), robust = T)
summary(felm(Spread ~ debt + SOFRV + Reserves, d2), robust = T)
