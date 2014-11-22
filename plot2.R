library(dplyr)

##Load the data to a data frame from the file
nei <- readRDS(file="data/summarySCC_PM25.rds")
nei <- tbl_df(nei)

##filter the baltimore data fips == "24510"
balt <- filter(nei, fips == "24510")

##use the dplyr group_by function to group the data by year
balt_year <- group_by(balt, year)

##summarize the data to calculate the total emissions by year
balt_sum <- summarise(balt_year, tot_emissions = sum(Emissions))

png("plot2.png")

##create the bar chart with the barplot function in Base R
bp1 <- barplot(balt_sum$tot_emissions, names=balt_sum$year, col = "Orange", ylim=c(0,4000), 
               xlab="Year", ylab="Total Emissions")
title(main = list("Total Emissions in Baltimore from 1999 to 2008", 
                  cex = 1.2, col = "red", font = 2))
text(bp1, 0, round(balt_sum$tot_emissions), cex=1.2, pos=3)

dev.off()