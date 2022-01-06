# Extra Crowding-Out by SOFR
#
# Qian Wu
# Local Projection
# ===========================================================================================================================
#                                                  House Keeping
# ===========================================================================================================================
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



# ===========================================================================================================================
#                                        Identify Govt Borrowing Shock
# ===========================================================================================================================

# Read Data
ip=read.csv('ip.csv')
stock=read.csv('SP500.csv')
debt=read.csv('debt.csv')
treasury_KS=read.csv('../../Klingler and Syrstad (2021)/ReplicateDaily.csv')
treasury_IS=read.csv('../../Infante and Saravay (2020)/replication/tsyOutData.csv')

# Data Cleaning
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

treasury_KS=treasury_KS[,-1]
treasury_KS$Date=as.Date(treasury_KS$Date)
names(treasury_KS)[8]="KStsy"
treasury_KS$month=factor(months(treasury_KS$Date), levels=month.name)
treasury_KS$year=format(treasury_KS$Date, format="%Y")
treasury_KS_m=aggregate(as.numeric(KStsy)~year+month, treasury_KS, mean)
treasury_KS_m=arrange(treasury_KS_m, year, month)
treasury_KS_m=treasury_KS_m[treasury_KS_m$year>2002 & treasury_KS_m$year<2020 ,]
names(treasury_KS_m)[3]="KStsy"

# Merge Shock Data
shock_data=merge(debt_m, ip_m, by=c("year", "month"), all=T)
shock_data=merge(shock_data, stock_m, by=c("year", "month"), all=T)
shock_data=merge(shock_data, treasury_KS_m, by=c("year", "month"), all=T)
shock_data=arrange(shock_data, year, month)
shock_data=shock_data[-1,]

# Identify Borrowing Shock
shock_reg_debt=lm(log(debt)~log(lag(debt, 1))+log(lag(debt, 2))+log(lag(debt, 3))+log(lag(debt, 4))+log(lag(debt, 5))+log(lag(debt, 6))+
               log(lag(IP, 1))+log(lag(IP, 2))+log(lag(IP, 3))+log(lag(IP, 4))+log(lag(IP, 4))+log(lag(IP, 5))+log(lag(IP, 6))+
               log(lag(SP500, 1))+log(lag(SP500, 2))+log(lag(SP500, 3))+log(lag(SP500, 4))+log(lag(SP500, 5))+log(lag(SP500, 6))+
               c(1:dim(shock_data)[1])+c(1:dim(shock_data)[1])^2, shock_data)
debt_shock=shock_reg_debt$residuals
plot(density(debt_shock))
shock_data$debt_shock=0
shock_data$debt_shock[7:dim(shock_data)[1]]=debt_shock

shock_data_KStsy=shock_data[is.na(shock_data$KStsy)==0, ]
shock_reg_KStsy=lm(KStsy~lag(KStsy, 1)+lag(KStsy, 2)+lag(KStsy, 3)+
               log(lag(IP, 1))+log(lag(IP, 2))+log(lag(IP, 3))+
               log(lag(SP500, 1))+log(lag(SP500, 2))+log(lag(SP500, 3))+
               c(1:dim(shock_data_KStsy)[1])+c(1:dim(shock_data_KStsy)[1])^2, shock_data_KStsy)
KStsy_shock=shock_reg_KStsy$residuals
plot(density(KStsy_shock))
shock_data$KStsy_shock=0
shock_data$KStsy_shock[142:dim(shock_data)[1]]=KStsy_shock

# Save Shock Data
write.csv(shock_data, "shock_data.csv", row.names=FALSE)




# ===========================================================================================================================
#                                        Prepare Local Projection Data
# ===========================================================================================================================

# Prepare Endogenous Data
lp_data=read.csv('../../ols/data/Master data/data_reg2_KS.csv')
lp_data=data.frame(Date=lp_data$Date, SOFR=lp_data$SOFR, LIBOR=lp_data$LIBOR, FFR=lp_data$FFR, index=lp_data$index)
lp_data$Date=as.Date(lp_data$Date)
lp_data$month=factor(months(lp_data$Date), levels=month.name)
lp_data$year=format(lp_data$Date, format="%Y")

# Monthly Average with Outliers
lp_data_out=aggregate(cbind(SOFR, LIBOR, FFR)~year+month, lp_data, mean)
lp_data_out=lp_data_out[lp_data_out$year>2002 & lp_data_out$year<2020, ]
lp_data_out=arrange(lp_data_out, year, month)

# Monthly Average without Outliers
lp_data_noout=aggregate(cbind(SOFR, LIBOR, FFR)~year+month, lp_data[lp_data$index==1,], mean)
lp_data_noout=lp_data_noout[lp_data_noout$year>2002 & lp_data_noout$year<2020, ]
lp_data_noout=arrange(lp_data_noout, year, month)


# Save Endogenous Data
write_csv(lp_data_out, "lp_data_out.csv")
write_csv(lp_data_noout, "lp_data_noout.csv")




# ===========================================================================================================================
#                                        Local Projection Regression
# ===========================================================================================================================
library(gridExtra)
library(ggpubr)
library(lpirfs)

# Read Data
shock_data=read.csv('shock_data.csv')
shock_data=shock_data[139:dim(shock_data)[1],]
end_data_out=read.csv('lp_data_out.csv')
end_data_noout=read.csv('lp_data_noout.csv')

# Set Variables
exog_data_debt=data.frame(log(shock_data[,c(3,4)]))
exog_data_KStst=data.frame(log(shock_data[,c(4,6)]))
SOFR_spread=data.frame(SOFR_spread=end_data_noout$SOFR-end_data_noout$FFR)
LIBOR_spread=data.frame(LIBOR_spread=end_data_noout$LIBOR-end_data_noout$FFR)
debt_shock=data.frame(shock_data[,7])
KStsy_shock=data.frame(shock_data[,8])

# Local Projection with IV
SOFR_iv_debt <- lp_lin_iv(endog_data = SOFR_spread, lags_endog_lin = 3,
shock = debt_shock, exog_data=exog_data_debt, lags_exog=3,
trend = 0, confint = 1, hor = 12)
plot_lin(SOFR_iv_debt)   

LIBOR_iv_debt <- lp_lin_iv(endog_data = LIBOR_spread, lags_endog_lin = 3,
shock = debt_shock, exog_data=exog_data_debt, lags_exog=3,
trend = 0, confint = 1, hor = 12)
plot_lin(LIBOR_iv_debt)   

SOFR_iv_KStsy <- lp_lin_iv(endog_data = data.frame(SOFR_spread[-c(1:3),]), lags_endog_lin = 3,
shock = data.frame(KStsy_shock[-c(1:3),]), exog_data=data.frame(exog_data_KStst[-c(1:3),]), lags_exog=3,
trend = 0, confint = 1, hor = 12)
plot_lin(SOFR_iv_KStsy)   

LIBOR_iv_KStsy <- lp_lin_iv(endog_data = data.frame(LIBOR_spread[-c(1:3),]), lags_endog_lin = 3,
shock = data.frame(KStsy_shock[-c(1:3),]), exog_data=data.frame(exog_data_KStst[-c(1:3),]), lags_exog=3,
trend = 0, confint = 1, hor = 12)
plot_lin(LIBOR_iv_KStsy)   



