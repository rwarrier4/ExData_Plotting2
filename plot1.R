library(dplyr)

##Load the data to a data frame from the file
nei <- readRDS(file="data/summarySCC_PM25.rds")
nei <- tbl_df(nei)

##use the dplyr group_by function to group the data by year
nei_year <- group_by(nei, year)

##summarize the data to calculate the total emissions by year
nei_sum <- summarise(nei_year, tot_emissions = sum(Emissions))

png("exdata-008/ExData_Plotting2/plot1.png")

##create the bar chart with the barplot function in Base R
bp1 <- barplot(nei_sum$tot_emissions/1000, names=nei_sum$year, col = "Orange", ylim=c(0,8000), 
               xlab="Year", ylab="Emissions (in thousand Tons)")
title(main = list("Total Emissions across the United States from 1999 to 2008", 
                                 cex = 1.2, col = "red", font = 2))
text(bp1, 0, round(nei_sum$tot_emissions/1000), cex=1.2, pos=3)

dev.off()