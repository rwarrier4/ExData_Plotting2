library(dplyr)
library(ggplot2)

##Load the nei data to a data frame from the file
nei <- readRDS(file="data/summarySCC_PM25.rds")
nei <- tbl_df(nei)

##Load the source code data to a data frame from the file
scc <- readRDS(file="data/Source_Classification_Code.rds")
scc <- tbl_df(scc)

##Select for Coal in EI.Sector or coal in SCC.Level.Three and Fuel Comb in EI.Sector 
scc1 <- filter(scc, grepl("[Cc]oal", EI.Sector) | grepl("[Cc]oal", SCC.Level.Three) & grepl("Fuel Comb", EI.Sector))

##Merge the NEI Data with the Filtered Source Code Data set using the SCC Code
neiscc <- merge(nei, scc1, by="SCC")

##Group by year
neiscc1 <- group_by(neiscc, year)

##summarize the data to calculate the total emissions by year
neiscc_sum <- summarise(neiscc1, tot_emissions = sum(Emissions))

neiscc_sum = transform(neiscc_sum, year = factor(year))

png("plot4.png")

##create a chart for Total Emissions by Coal across the United States
g <- ggplot(neiscc_sum, aes(x=year, y=tot_emissions/1000)) + 
        geom_bar(fill = "Orange", stat="Identity") + 
        ylab("Total Emissions (in thousand Tons)") + 
        ggtitle("Total Emissions from Coal") +
        geom_text(aes(label = round(tot_emissions/1000)), y=200, size = 6) +
        theme(
                axis.text = element_text(size = 12),
                axis.title = element_text(size = 14)
        )

print(g)

dev.off()
