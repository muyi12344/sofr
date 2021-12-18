# Extra Crowding-Out by SOFR
#
# Qian Wu
# OLS
# ==============================================================================================
# Set work directory
rm(list = ls())
WORK.DIR = "/Users/mac/Desktop/Research/sofr/ols/data"
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



# Read Data
sofr=read.csv('sofr.csv')
libor=read.csv('libor.csv')
debt=read.csv('debt.csv')
ffr=read.csv('ffr.csv')
volume=read.csv('volume.csv')

debt$Record.Date=as.Date(debt$Record.Date, format="%m/%d/%y" )
names(debt)=c('Date', 'Public', 'Govt', 'Total')

sofr$Date=as.Date(sofr$Date, format="%m/%d/%y")
sofr=sofr[,1:2]
names(sofr)=c('Date', 'SOFR')
sofr$SOFR=as.numeric(sofr$SOFR)
sofr$SOFR[c(900:1841)]=100*sofr$SOFR[c(900:1841)]

libor$DATE=as.Date(libor$DATE)
names(libor)=c('Date', 'LIBOR')
libor$LIBOR=as.numeric(libor$LIBOR)
libor$LIBOR=libor$LIBOR*100

ffr$DATE=as.Date(ffr$DATE)
names(ffr)=c('Date', 'FFR')
ffr$FFR=as.numeric(ffr$FFR)*100

volume=
volume %>% 
  separate(Date, c("month", "day", "year"), sep = "/")
volume$Date<-as.Date(with(volume,paste(month,day,year,sep="/")),"%m/%d/%y")
volume=volume[, -c(1:3)]

data=merge(sofr, libor, by="Date")
data=merge(data, ffr, by="Date")
data=merge(data, debt, by='Date')
data=merge(data, volume, by="Date")

log_Total=log(data$Total)
data$log_Total=log_Total
change_Total=c(0,diff(log(data$Total), lag=1))
data$change_Total=change_Total

log_Public=log(data$Public)
data$log_Public=log_Public
change_Public=c(0,diff(log(data$Public), lag=1))
data$change_Public=change_Public

data$SOFR_spread=data$SOFR-data$FFR
data$SOFR_spread_change=c(0, diff(data$SOFR_spread, lag=1))

data$LIBOR_spread=data$LIBOR-data$FFR
data$LIBOR_spread_change=c(0, diff(data$LIBOR_spread, lag=1))

data$log_Volume=log(data$Volume)
data$difflog_Volume=c(0, diff(data$log_Volume, lag=1))

data_reg=data[-c(1, 1263:1267), ]



# Data Visualization
meltdf <- melt(data_reg[, c(1, 16, 18)],id="Date")
ggplot(meltdf, aes(x=Date, y=value, color=variable, group=variable)) +
  geom_line(size=1)+
  scale_x_date(limit=c(as.Date("2014-08-01"),as.Date("2020-01-01")),
               date_breaks="3 month",date_labels = "%m/%y",
               date_minor_breaks ="3 month")+
  labs(x="", y="Basis Points")+
  scale_color_manual("Benchmark Rate",values=c("cyan4","coral"), labels=c("SOFR", "LIBOR"))+
  theme(panel.background = element_rect(fill = NA),
        panel.grid.major = element_line(colour = "grey90"),
    legend.position = c(.95, .95),
    legend.justification = c("right", "top"),
    legend.box.just = "right",
    legend.margin = margin(6, 6, 6, 6),
    axis.title=element_text(size=14),
    legend.text=element_text(size=14),
    legend.title = element_text(size = 14)
  )




# Remove the first, last, and second-last days in each month
first=setDT(data_reg)[order(Date), .(Date[which.min(Date)]), 
                by=.(year(Date), month(Date))]
index_first=match(first$V1, data_reg$Date)[-1]
data_reg=data_reg[-index_first, ]

last=setDT(data_reg)[order(Date), .( Date[which.max(Date)]), 
               by=.(year(Date), month(Date))]
index_last=match(last$V1, data_reg$Date)
data_reg=data_reg[-index_last, ]

last=setDT(data_reg)[order(Date), .( Date[which.max(Date)]), 
                     by=.(year(Date), month(Date))]
index_last=match(last$V1, data_reg$Date)
data_reg=data_reg[-index_last, ]

write_dta(data_reg, 'data_reg.dta')



# Regression 2
reg2=lm(SOFR_spread_change~change_Public, data=data_reg)
reg2_sum1=coeftest(reg2, vcov.=NeweyWest(reg2, lag=10, prewhite=FALSE, adjust=TRUE, verbose=TRUE))
reg2_2=lm(SOFR_spread_change~change_Public+lag(SOFR_spread_change), data=data_reg)
reg2_sum2=coeftest(reg2_2, vcov.=NeweyWest(reg2_2, lag=10, prewhite=FALSE, adjust=TRUE, verbose=TRUE))
reg2_3=lm(LIBOR_spread_change~change_Public, data=data_reg)
reg2_sum3=coeftest(reg2_3, vcov.=NeweyWest(reg2_3, lag=10, prewhite=FALSE, adjust=TRUE, verbose=TRUE))
reg2_4=lm(LIBOR_spread_change~change_Public+lag(LIBOR_spread_change), data=data_reg)
reg2_sum4=coeftest(reg2_4, vcov.=NeweyWest(reg2_4, lag=10, prewhite=FALSE, adjust=TRUE, verbose=TRUE))
fit1_r2=round(summary(reg2)$adj.r.squared, 4)
fit2_r2=round(summary(reg2_2)$adj.r.squared, 4)
fit3_r2=round(summary(reg2_3)$adj.r.squared, 4)
fit4_r2=round(summary(reg2_4)$adj.r.squared, 4)
stargazer(reg2_sum1, reg2_sum2, reg2_sum3, reg2_sum4, type="latex",
          align = T, dep.var.labels=c("SOFR", "LIBOR"),
          covariate.labels=c("Government debt", "Lagged SOFR", "Lagged LIBOR"),
          column.sep.width = "1pt", no.space = T,
          add.lines = list(c("Adjusted $R^2$", fit1_r2, fit2_r2, fit3_r2, fit4_r2), c("Observations", 1135, 1134, 1100, 1082)))




# Data for Reg1
pri_repo=read.csv('primary_repo.csv')
pri_repo$date=as.Date(pri_repo$date)
names(pri_repo)=c('Date', 'repo')
data_week=merge(pri_repo, debt, by="Date")
data_week$log_repo=log(data_week$repo)
data_week$change_repo=c(0, diff(data_week$log_repo, lag=1))
data_week$log_public=log(data_week$Public)
data_week$change_public=c(0, diff(data_week$log_public))
write_dta(data_week, 'data_week.dta')



# Regression 1
reg1=lm(change_repo~change_public, data=data_week)
reg1_sum1=coeftest(reg1, vcov.=NeweyWest(reg1, lag=4, prewhite=FALSE, adjust=TRUE, verbose=TRUE))
reg1_2=lm(change_repo~change_public+lag(change_repo), data=data_week)
reg1_sum2=coeftest(reg1_2, vcov.=NeweyWest(reg1_2, lag=4, prewhite=FALSE, adjust=TRUE, verbose=TRUE))
fit1_r2=round(summary(reg1)$adj.r.squared, 4)
fit2_r2=round(summary(reg1_2)$adj.r.squared, 4)
stargazer(reg1_sum1,reg1_sum2, type="latex", title="Effect of Government Debt on Primary Dealers' Repo Activity",
          align=T, dep.var.labels=c("Primary dealers' Repo"),
          covariate.labels=c("Government debt", "Lagged primary dealers' Repo"),
          add.lines = list(c("Adjusted $R^2$", fit1_r2, fit2_r2), c("Observations", 351, 350)),
          column.sep.width = "1pt", no.space = T)



# Business Debt Components Visualization
business=read.csv('business.csv')
business[, -1]=business[, -1]/1000
business$year=str_sub(business$date, 1,4)
business$quarter=str_sub(business$date, -1)
business$date=as.yearqtr(paste0(business$year, "-", business$quarter))
business=business[, -c(7,8)]

meltdf <- melt(business,id="date")
meltdf=arrange(meltdf, date, variable)
ggplot(meltdf, aes(x=date, y=value, fill=variable)) + 
  geom_area()+
  ylab("billions USD")+
  xlab("")+
  theme(panel.background = element_rect(fill = NA),
        panel.grid.major = element_line(colour = "grey90"),
        legend.position = c(.05, .95),
        legend.justification = c("left", "top"),
        legend.box.just = "left",
        legend.margin = margin(6, 6, 6, 6),
        axis.title=element_text(size=14),
        legend.text=element_text(size=14),
        legend.title = element_text(size = 14)
  )









