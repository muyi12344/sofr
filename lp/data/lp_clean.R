# Extra Crowding-Out by SOFR
#
# Qian Wu
# Local Projection
# ==============================================================================================
# Set work directory
rm(list = ls())
WORK.DIR = "/Users/mac/Desktop/Research/sofr/lp/data"
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



# Read Shock Data
ip=read.csv('ip.csv')
stock=read.csv('SP500.csv')
debt=read.csv('debt.csv')

debt$Date=as.Date(debt$Date, format="%m/%d/%y" )
debt$month=factor(months(debt$Date), levels=month.name)
debt$year=format(debt$Date, format="%Y")
debt=debt[debt$Public!="null",]
debt_m=aggregate(as.numeric(Public)~year+month, debt, mean)
debt_m=arrange(debt_m, year, month)
debt_m=debt_m[debt_m$year>2002 & debt_m$year<2020 ,]
names(debt_m)[3]="debt"

ip$Date=as.Date(ip$Date, format = "%m/%d/%y")
ip$month=factor(months(ip$Date), levels=month.name)
ip$year=format(ip$Date, format="%Y")
ip_m=aggregate(IP~year+month, ip, mean)
ip_m=ip_m[ip_m$year>2002 & ip_m$year<2020, ]
ip_m=arrange(ip_m, year, month)

stock=stock[1:204,]
index=str_sub(stock$Date, 1, 1)
for (i in 1:length(stock$Date)){
  if (index[i]!="1") {
    stock$Date[i]=str_c("0", stock$Date[i], "")
  }
}
stock$Date=str_c(stock$Date, "-01")
Date=as.Date(stock$Date, format = "%y-%b-%d")
stock$Date=Date
stock$month=factor(months(stock$Date), levels=month.name)
stock$year=format(stock$Date, format="%Y")
stock$SP500=gsub(",","", stock$SP500)
stock_m=aggregate(as.numeric(SP500)~year+month, stock, mean)
names(stock_m)[3]="SP500"
stock_m=stock_m[stock_m$year>2002 & stock_m$year<2020, ]
stock_m=arrange(stock_m, year, month)



# Save Shock Data
shock_data=merge(debt_m, ip_m, by=c("year", "month"))
shock_data=merge(shock_data, stock_m, by=c("year", "month"))
shock_data=arrange(shock_data, year, month)
write_csv(shock_data, "shock_data.csv")



# Identify Debt Shock
shock_reg=lm(log(debt)~log(lag(debt, 1))+log(lag(debt, 2))+log(lag(debt, 3))+log(lag(debt, 4))+
               log(lag(IP, 1))+log(lag(IP, 2))+log(lag(IP, 3))+log(lag(IP, 4))+
               log(lag(SP500, 1))+log(lag(SP500, 2))+log(lag(SP500, 3))+log(lag(SP500, 4))+
               c(1:203), shock_data)
debt_shock=shock_reg$residuals




# Read Local Projection Data
sofr=read.csv('sofr.csv')
libor=read.csv('libor.csv')
ffr=read.csv('ffr.csv')

sofr$Date=as.Date(sofr$Date, format="%m/%d/%y")
sofr=sofr[,1:2]
names(sofr)=c('Date', 'SOFR')
sofr$SOFR=as.numeric(sofr$SOFR)
sofr$SOFR[c(900:1841)]=100*sofr$SOFR[c(900:1841)]
sofr$month=factor(months(sofr$Date), levels=month.name)
sofr$year=format(sofr$Date, format="%Y")
sofr_m=aggregate(SOFR~year+month, sofr, mean)
sofr_m=sofr_m[sofr_m$year>2002 & sofr_m$year<2020, ]
sofr_m=arrange(sofr_m, year, month)

libor$DATE=as.Date(libor$DATE)
names(libor)=c('Date', 'LIBOR')
libor$LIBOR=as.numeric(libor$LIBOR)
libor$LIBOR=libor$LIBOR*100
libor$month=factor(months(libor$Date), levels=month.name)
libor$year=format(libor$Date, format="%Y")
libor_m=aggregate(LIBOR~year+month, libor, mean)
libor_m=libor_m[libor_m$year>2002 & libor_m$year<2020, ]
libor_m=arrange(libor_m, year, month)

ffr$DATE=as.Date(ffr$DATE)
names(ffr)=c('Date', 'FFR')
ffr$FFR=as.numeric(ffr$FFR)*100
ffr$month=factor(months(ffr$Date), levels=month.name)
ffr$year=format(ffr$Date, format="%Y")
ffr_m=aggregate(FFR~year+month, ffr, mean)
ffr_m=ffr_m[ffr_m$year>2002 & ffr_m$year<2020,]
ffr_m=arrange(ffr_m, year, month)



# Save Local Projection Data
lp_data=merge(libor_m, sofr_m, by=c("year", "month"))
lp_data=merge(lp_data, ffr_m, by=c("year", "month"))
lp_data=merge(lp_data, shock_data, by=c("year", "month"))
write_csv(lp_data, "lp_data.csv")












