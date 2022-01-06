# Extra Crowding-Out by SOFR
#
# Qian Wu
#
# OLS
#
# ===========================================================================================================================
#                                                  House Keeping
# ===========================================================================================================================
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
library(lfe)


# ===========================================================================================================================
#                                        Reg 2: SOFR,LIBOR and Govt Borrowing
# ===========================================================================================================================

# ------------------------------------------------------------------------------
# Govt debt outstanding as the borrowing measure 
# ------------------------------------------------------------------------------

# Read Data
sofr=read.csv('sofr.csv')
libor=read.csv('libor.csv')
debt=read.csv('debt.csv')
ffr=read.csv('ffr.csv')
vol_rate=read.csv('vol_rate.csv')


# Clean Data
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

vol_rate=read.csv('vol_rate.csv')
vol_rate$Date=as.Date(vol_rate$Date, format="%m/%d/%y")

data=merge(sofr, libor, by="Date")
data=merge(data, ffr, by="Date")
data=merge(data, debt, by='Date')
data=merge(data, vol_rate, by="Date", all=T)

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

data$Volume=data$Tri_Party_vol+data$GC_vol+data$Bilateral_vol
data$log_Volume=log(data$Volume)
data$difflog_Volume=c(0, diff(data$log_Volume, lag=1))

data_reg=data


# SOFR and LIBOR Visualization
data_reg=data_reg[(1-(data_reg$Date>="2019-9-16" & data_reg$Date<="2019-9-20")==1), ]
meltdf <- melt(data_reg[, c(1, 18, 20)],id="Date")
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


# Indicate Outliers
data_reg=data
#   the week 9/16/2019-9/20/2019
index1=(data_reg$Date>="2019-9-16" & data_reg$Date<="2019-9-20")==FALSE
index1=as.numeric(index1)

#   the first, last, and second-last days in each month
index2=rep(1, dim(data_reg)[1])
first=setDT(data_reg)[order(Date), .(Date[which.min(Date)]), 
                by=.(year(Date), month(Date))]
index_first=match(first$V1, data_reg$Date)[-1]
index2[index_first]=0

last=setDT(data_reg)[order(Date), .( Date[which.max(Date)]), 
               by=.(year(Date), month(Date))]
index_last=match(last$V1, data_reg$Date)
index2[index_last]=0

last=setDT(data_reg[index2==1,])[order(Date), .( Date[which.max(Date)]), 
                     by=.(year(Date), month(Date))]
index_last2=match(last$V1, data_reg$Date)
index2[index_last2]=0


# combine index1 and index2
index=index1*index2
data_reg$index=index


# Save data
write_dta(data_reg, 'Master data/data_reg2_debt.dta')
write.csv(data_reg, 'Master data/data_reg2_debt.csv', row.names=F)


# Regression 2
data_reg=read.csv('Master data/data_reg2_debt.csv')
reg2_debt=felm(SOFR_spread_change~change_Public, data=data_reg[data_reg$index==1,], na.action=na.exclude)
summary(reg2_debt, robust=T)
reg2_debt_2=felm(SOFR_spread_change~change_Public+lag(SOFR_spread_change,1), data=data_reg[data_reg$index==1,], na.action=na.exclude)
summary(reg2_debt_2, robust=T)
reg2_debt_3=felm(LIBOR_spread_change~change_Public, data=data_reg[data_reg$index==1,], na.action=na.exclude)
summary(reg2_debt_3, robust=T)
reg2_debt_4=felm(LIBOR_spread_change~change_Public+lag(LIBOR_spread_change,1), data=data_reg[data_reg$index==1,], na.action=na.exclude)
summary(reg2_debt_4, robust=T)

stargazer(reg2_debt,reg2_debt_2,reg2_debt_3,reg2_debt_4, type="latex",
          align=T, dep.var.labels=c("SOFR", "LIBOR"), 
          no.space = T)




# ------------------------------------------------------------------------------
# Treasuries outstanding (Klingler and Syrstad (2021)) as the borrowing measure 
# ------------------------------------------------------------------------------

# Read Data
data_reg2_KS=read.csv('../../Klingler and Syrstad (2021)/ReplicateDaily.csv')
data_reg=read.csv('Master data/data_reg2_debt.csv')
data_reg$Date=as.Date(data_reg$Date)

# Clean Data
data_reg2_KS=data_reg2_KS[,-1]
data_reg2_KS$Date=as.Date(data_reg2_KS$Date)
data_reg=merge(data_reg, data_reg2_KS[,c(1, 8)], by="Date", all=T)
names(data_reg)[26]="log_KStsy"
data_reg$difflog_KStsy=c(0, diff(data_reg$log_KStsy,1))


# Save data
write_dta(data_reg, 'Master data/data_reg2_KS.dta')
write.csv(data_reg, 'Master data/data_reg2_KS.csv', row.names = F)


# Regression 2
data_reg=read.csv('Master data/data_reg2_KS.csv')
reg2_debt=felm(SOFR_spread_change~difflog_KStsy, data=data_reg[data_reg$index==1,], na.action=na.exclude)
summary(reg2_debt, robust=T)
reg2_debt_2=felm(SOFR_spread_change~difflog_KStsy+lag(SOFR_spread_change,1), data=data_reg[data_reg$index==1,], na.action=na.exclude)
summary(reg2_debt_2, robust=T)
reg2_debt_3=felm(LIBOR_spread_change~difflog_KStsy, data=data_reg[data_reg$index==1,], na.action=na.exclude)
summary(reg2_debt_3, robust=T)
reg2_debt_4=felm(LIBOR_spread_change~difflog_KStsy+lag(LIBOR_spread_change,1), data=data_reg[data_reg$index==1,], na.action=na.exclude)
summary(reg2_debt_4, robust=T)

stargazer(reg2_debt,reg2_debt_2,reg2_debt_3,reg2_debt_4, type="latex",
          align=T, dep.var.labels=c("SOFR", "LIBOR"), 
          no.space = T)



# ------------------------------------------------------------------------------
# Treasuries outstanding (Infante and Saravay (2020)) as the borrowing measure 
# ------------------------------------------------------------------------------

# Read Data
data_reg2_IS=read.csv('../../Infante and Saravay (2020)/replication/tsyOutData.csv')
data_reg=read.csv('Master data/data_reg2_KS.csv')
data_reg$Date=as.Date(data_reg$Date)

# Clean Data
data_reg2_IS$IStsy=data_reg2_IS$TbillsOut+data_reg2_IS$ShTbillsOut+data_reg2_IS$USTNotesOut
names(data_reg2_IS)[1]="Date"
data_reg2_IS$Date=as.Date(data_reg2_IS$Date)
data_reg=merge(data_reg, data_reg2_IS[, c(1,5)], by="Date")
data_reg$log_IStsy=log(data_reg$IStsy)
data_reg$difflog_IStsy=c(0, diff(data_reg$log_IStsy,1))

# Save Data
write_dta(data_reg, 'Master data/data_reg2_IS.dta')
write.csv(data_reg, 'master data/data_reg2_IS.csv', row.names = F)

# Regression 2
data_reg=read.csv('master data/data_reg2_IS.csv')
reg2_debt=felm(SOFR_spread_change~difflog_IStsy, data=data_reg[data_reg$index==1,], na.action=na.exclude)
summary(reg2_debt, robust=T)
reg2_debt_2=felm(SOFR_spread_change~difflog_IStsy+lag(SOFR_spread_change,1), data=data_reg[data_reg$index==1,], na.action=na.exclude)
summary(reg2_debt_2, robust=T)
reg2_debt_3=felm(LIBOR_spread_change~difflog_IStsy, data=data_reg[data_reg$index==1,], na.action=na.exclude)
summary(reg2_debt_3, robust=T)
reg2_debt_4=felm(LIBOR_spread_change~difflog_IStsy+lag(LIBOR_spread_change,1), data=data_reg[data_reg$index==1,], na.action=na.exclude)
summary(reg2_debt_4, robust=T)




# ===========================================================================================================================
#                              Reg 1: Primary Dealers Repo Volume and Govt Borrowing
# ===========================================================================================================================

# ------------------------------------------------------------------------------
# Govt debt outstanding as the borrowing measure 
# ------------------------------------------------------------------------------

# Read Data
pri_repo=read.csv('primary_repo.csv')

# Clean Data
pri_repo$date=as.Date(pri_repo$date)
names(pri_repo)=c('Date', 'repo')
data_week=merge(pri_repo, debt, by="Date")
data_week$log_repo=log(data_week$repo)
data_week$change_repo=c(0, diff(data_week$log_repo, lag=1))
data_week$log_public=log(data_week$Public)
data_week$change_public=c(0, diff(data_week$log_public))

# Save Data
write_dta(data_week, 'Master data/data_reg1_debt.dta')
write.csv(data_week, 'Master data/data_reg1_debt.csv')


# Regression 1
reg1_debt=felm(change_repo~change_public, data=data_week)
summary(reg1_debt, robust=T)






# ===========================================================================================================================
#                              Business Debt Decomposition
# ===========================================================================================================================

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




# ===========================================================================================================================
#                              SOFR Underlying Transactions Decomposition
# ===========================================================================================================================
data_reg=read.csv('Master data/data_reg2_debt.csv')
data_reg$Date=as.Date(data_reg$Date)
volume=data_reg[, c(1,8,9,10)]
volume$GC=volume$Tri_Party_vol+volume$GC_vol
volume$SC=volume$Bilateral_vol

meltdf <- melt(volume[,c(1,5,6)],id="Date")
meltdf=na.exclude(meltdf)
names(meltdf)[2]="Transaction_Type"
meltdf=arrange(meltdf, Date,Transaction_Type )
ggplot(meltdf, aes(x=Date, y=value, fill=Transaction_Type)) + 
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



# ===========================================================================================================================
#                              Reg 3: Bilateral Rate and Govt Borrowing
# ===========================================================================================================================

data=read.csv('Master data/data_reg2_KS.csv')
rate=data[, c(1,4,8:13,17,25,27)]
rate$GC_rate=(rate$Tri_Party_vol*rate$Tri_Party_rate+rate$GC_vol*rate$GC_rate)/(rate$Tri_Party_vol+rate$GC_vol)
rate$SC_rate=rate$Bilateral_rate
lines(rate$Date, rate$SC_rate)
rate$GC_rate_change=c(0, diff(rate$GC_rate_spread, 1))
rate$SC_rate_change=c(0, diff(rate$SC_rate_spread, 1))
reg3=felm(SC_rate_change-GC_rate~difflog_KStsy, rate[rate$index==1,], na.action = na.exclude)
summary(reg3, robust=T)
rate$log_GC_vol=log(rate$Tri_Party_vol+rate$GC_vol)
rate$log_SC_vol=log(rate$Bilateral_vol)
rate$difflog_GC_vol=c(0, diff(rate$log_GC_vol))
rate$difflog_SC_vol=c(0, diff(rate$log_SC_vol))
reg3_2=felm(GC_rate_spread_change-SC_rate_spread_change~difflog_KStsy+difflog_GC_vol+difflog_SC_vol, rate, na.action = na.exclude)
summary(reg3_2, robust=T)


stargazer(reg3,reg3_2, type="latex",
          align=T, dep.var.labels=c('SC repo rate - GC repo rate'), 
          no.space = T)

