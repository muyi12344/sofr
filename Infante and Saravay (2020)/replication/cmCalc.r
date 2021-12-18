#This R script calculates the dealer-level and average Treasury collateral multipliers (CMs) for the paper "What Drives U.S. Treasury Re-use" by Sebastian Infante and Zack Saravay. It should only be accessed by those with permission to use the FR2052a Complex Institution Liquidity Monitoring Report data. 
#The program consists of four functions. The first pulls and anonymizes the data, the second applies initial cleaning to the data, the third calculates the dealer-level all contracts and repo CMs, and the fourth calculates averages of the all contracts and repo CMs for all dealers, US dealers, and non-US dealers.
#The average and dealer-level CMs are then used to estimate time series regressions and simultaneous equation regressions. The cmAverage and cmDealer csvs are used as inputs to the CMregressions_MasterTS.do and CMregressions_MasterInd.do files, respectively.

library(RPostgreSQL)
library(fiaSQLParallel)
library(tidyr)

#################################
#### Pull and anonymize data ####
#################################

#This function pulls from the secured outflows table of the FR2052a data. It pulls data for the 9 largest primary dealers, filtering for only Treasury collateral and transactions where the collateral value is denominated in USD. Because the primary dealer for two of the companies in our sample switched during the time period of our analysis, we pull data for each of the two dealer entities for those two companies, and the data is adjusted later to create a continuous series for each company.
#This function also identifies each dealer's jurisdiction as either domestic or foreign, based on the location of the parent company's headquarters.
#Finally, the function anonymizes the names of both the specific reporting entities and the parent companies.
pullOutflowsData <- function(){
     
#Select firm names
     firmString <- "(reporting_party='JPMorgan Securities LLC'  OR reporting_party='Barclays Capital Inc' OR reporting_party='DB Securities Inc'  OR reporting_party='Credit Suisse Securities (USA) LLC' OR reporting_party='Citigroup Global Markets Inc' OR reporting_party='Morgan Stanley and Co LLC' OR reporting_party='Goldman Sachs and Co' OR reporting_party='WF Securities' OR reporting_party='MLPFS' OR reporting_party='BofAS - BOFA SECURITIES, INC' OR reporting_party='Credit Suisse - Consolidated US Operations')"

#Load outflows data using fiaSQLParallel package
     print("Loading outflows data ...")
     system("date")

     outflowsArgs <- c("host:pgdp1","schema:fr2052a","dbname:fia","table:outflows_secured_vw", "columns:date, fwd_start, fwd_start_currency, company_name, reporting_party, product, sub_product1, collateral_class, maturity, maturity_value, collateral_value, internal_ind, prim_brkrg_ind, settlement_type, rehypothecated_ind, tsy_ctrl_ind, counterparty_type, internal_counterparty", paste("filters: (collateral_value_currency='USD') AND (collateral_class = 'A-1' OR collateral_class = 'A-1-Q') AND", firmString),"order_by:date")
     outflowsRaw <- getSQLData(outflowsArgs)

     if(is.data.frame(outflowsRaw)) {
          print("Outflows data loaded.")
     } else {
          print("Outflows data failed to load.")
     }
     system("date")

     #Add column indicating jursidiction of dealer
     outflowsRaw$jurisdiction <- recode(outflowsRaw$company_name, "JPMorgan Chase" = "domestic", "Barclays" = "foreign", "Deutsche Bank" = "foreign", "Credit Suisse" = "foreign", "Citigroup" = "domestic", "Morgan Stanley" = "domestic", "Goldman Sachs" = "domestic", "Wells Fargo" = "domestic", "Bank of America" = "domestic")

     #Anonymize reporting party and counterparty name
     outflowsRaw$reporting_party <- recode(outflowsRaw$reporting_party, "JPMorgan Securities LLC" = "Dealer1", "Barclays Capital Inc" = "Dealer2", "DB Securities Inc" = "Dealer3", "Credit Suisse Securities (USA) LLC" = "Dealer4.1", "Credit Suisse - Consolidated US Operations" = "Dealer4.2", "Citigroup Global Markets Inc" = "Dealer5", "Morgan Stanley and Co LLC" = "Dealer6", "Goldman Sachs and Co" = "Dealer7", "WF Securities" = "Dealer8", "MLPFS" = "Dealer 9.1", "BofAS - BOFA SECURITIES, INC" = "Dealer9.2")
     outflowsRaw$company_name <- recode(outflowsRaw$company_name, "JPMorgan Chase" = "Dealer1", "Barclays" = "Dealer2", "Deutsche Bank" = "Dealer3", "Credit Suisse" = "Dealer4", "Citigroup" = "Dealer5", "Morgan Stanley" = "Dealer6", "Goldman Sachs" = "Dealer7", "Wells Fargo" = "Dealer8", "Bank of America" = "Dealer 9")

     
return(outflowsRaw)     
}

##########################
#### Initial Cleaning ####
##########################

#This function cleans the FR2052a outflows data. It cuts off the data for a selected  start and end date, removes unsettled transactions, and adjusts for companies whose primary dealer switched to a different subsidiary during our time period.
cleanOutflowsData <- function(x, startDate = "2016-01-01", endDate = Sys.Date(), removeUnsettled = TRUE, primaryDealerAdjust = TRUE){
      
     print(paste("Cleaning", deparse(substitute(x)), "..."))
     
     x <- as.data.frame(subset(x, date <= endDate & date >= startDate))
 

     #Remove unsettled transactions
     if(removeUnsettled) {
          #subset where forward start is zero or NA, which represents settled transactions
          x <- subset(x, fwd_start == 0 | is.na(fwd_start))
          print("Forward starts removed")
     }

     #Remove spaces from company names
     x$company_name <- gsub(" ", "", x$company_name)
     x$reporting_party <- gsub(" ", "", x$reporting_party)

     #Recode internal_ind column to strings
     if("internal_ind" %in% colnames(x)) {
          x$internal_ind <- as.character(x$internal_ind)
          x$internal_ind <- recode(x$internal_ind, "TRUE" = "internal", "FALSE" = "external")
          x$internal_ind <- recode(x$internal_ind, "Y" = "internal", "N" = "external")
     }

     #Adjust for primary dealer switches
     if(primaryDealerAdjust){
          #Adjust for Credit Suisse primary dealer change
          x <- subset(x, !(reporting_party=="Dealer4.1" & date>="2017-11-13"))
          x <- subset(x, !(reporting_party=="Dealer4.2" & date<"2017-11-13"))

          #Adjust for BOA primary dealer change
          x <- subset(x, !(reporting_party=="Dealer9.1" & date>="2019-05-13"))
          x <- subset(x, !(reporting_party=="Dealer9.2" & date<"2019-05-13"))
          print("Adjusted primary dealers.")
     }

return(x)
}

####################################
#### Calculate Dealer-Level CMs ####
####################################

#This function calculates the all collateral and repo collateral multpliers at the date-dealer level. First, it sums the outflows data at the date-dealer level to calculate the numerators and demoninator of the two CMs. Only external transactions are included. Second, it calculates the CMs by dividing each numerator by the denominator. Finally, it outputs the anonymized dealer-level CMs in a csv file.

dealerLevelCm <- function(outflows) {

     #### Calculate CM numerators ####
     
     #Sum the collateral value of external treasury SFT outflows (all contracts)for each date and dealer
     allContractsDealer <- as.data.frame(outflows
                                  %>% filter(internal_ind == "external")
                                  %>% group_by(company_name, jurisdiction, date)
                                  %>% summarise(allContracts = sum(collateral_value, na.rm = TRUE)))

     #Sum the collateral value of external treasury repo for each date and dealer
     repoDealer <- as.data.frame(outflows
                           %>% filter(product == "Repo" & internal_ind == "external")
                           %>% group_by(company_name, jurisdiction, date)
                           %>% summarise(repo = sum(collateral_value, na.rm = TRUE)))
     #### Calculate CM denominator ####

     #Sum the collateral value of external treasury non-rehypothecated SFT outflows (all contracts) for each date and dealer
     nonRehyAllContractsDealer <- as.data.frame(outflows %>% filter(rehypothecated_ind == FALSE & internal_ind == "external") %>% group_by(company_name, jurisdiction, date) %>% summarise(nonRehyAllContracts = sum(collateral_value, na.rm = TRUE)))

     #### Calculate dealer-level multipliers ####

     #Merge numerators and denominator of CM at date-dealer level
     cmDealer <- Reduce(function(x,y) merge(x,y, all = TRUE), list(allContractsDealer, repoDealer, nonRehyAllContractsDealer))
     #Replace NAs with zeroes
     cmDealer[is.na(cmDealer)] <- 0

     #Calculate all contracts CM as total SFT outflows divided by non-rehypothecated SFT outflows
     cmDealer$cmAllContracts <- cmDealer$allContracts / cmDealer$nonRehyAllContracts
     #Calculate repo CM as repo divided by non-rehypothecated SFT outflows
     cmDealer$cmRepo <- cmDealer$repo / cmDealer$nonRehyAllContracts

     #Subset for relevant columns
     cmDealer <- cmDealer[,c("date", "company_name", "jurisdiction", "cmAllContracts", "cmRepo")]

     #Output dealer-level CMs in a csv file
     write.csv(cmDealer, "cmDealer.csv", row.names = FALSE)
     
     return(cmDealer)
}

###############################
#### Calculate Average CMs ####
###############################

#This function calculates the cross-sectional average all contracts and repo CMs, averaging separately across all dealers, US dealers, and non-US dealers. It then outputs the average CMs in a csv file.
averageCm <- function(cmDealer) {

     #### Calculate average all contracts CMs ####
     
     #Take cross-sectional average across all contracts CMs
     cmAllContracts <- as.data.frame(cmDealer %>% group_by(date) %>% summarise(Avg_USText = mean(cmAllContracts, na.rm = TRUE)))
     #Take cross-sectional average across US dealers' all contracts CMs
     cmAllContractsUS <- as.data.frame(cmDealer %>% filter(jurisdiction == "domestic") %>% group_by(date) %>% summarise(AvgUS_USText = mean(cmAllContracts, na.rm = TRUE)))
     #Take cross-sectional average across non-US dealers' all contracts CMs
     cmAllContractsNonUS <- as.data.frame(cmDealer %>% filter(jurisdiction == "foreign") %>% group_by(date) %>% summarise(AvgRoW_USText = mean(cmAllContracts, na.rm = TRUE)))

     #### Calculate average repo CMs ####
     
     #Take cross-sectional average across repo CMs
     cmRepo <- as.data.frame(cmDealer %>% group_by(date) %>% summarise(Avg_USTextRP = mean(cmRepo, na.rm = TRUE)))
     #Take cross-sectional average across US dealers' repo CMs
     cmRepoUS <- as.data.frame(cmDealer %>% filter(jurisdiction == "domestic") %>% group_by(date) %>% summarise(AvgUS_USTextRP = mean(cmRepo, na.rm = TRUE)))
     #Take cross-sectional average across non-US dealers' repo CMs
     cmRepoNonUS <- as.data.frame(cmDealer %>% filter(jurisdiction == "foreign") %>% group_by(date) %>% summarise(AvgRoW_USTextRP = mean(cmRepo, na.rm = TRUE)))

     #### Merge CMs ####

     cmAverage <- Reduce(function(x,y) merge(x,y, all = TRUE), list(cmAllContracts, cmAllContractsUS, cmAllContractsNonUS, cmRepo, cmRepoUS, cmRepoNonUS))

     #Output average CMs into a csv file
     write.csv(cmAverage, "cmAverage.csv", row.names = FALSE)

     return(cmAverage)

}
     
######################
#### Main Program ####
######################


#Run function to pull and anonymize FR2052a outflows data
outflowsRaw <- pullOutflowsData()

#Run function to clean FR2052a outflowsData
outflows <- cleanOutflowsData(x=outflowsRaw, startDate = "2016-01-01", endDate = "2020-04-17")

#Run function to calculate and output dealer-level CMs
cmDealer <- dealerLevelCm(outflows)

#Run function to calculate and output average CMs
cmAverage <- averageCm(cmDealer)
