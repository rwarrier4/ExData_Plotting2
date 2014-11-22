library(ggplot2)
library(dplyr)

##Load the nei data to a data frame from the file
nei <- readRDS(file="data/summarySCC_PM25.rds")
nei <- tbl_df(nei)

##Load the source code data to a data frame from the file
#scc <- readRDS(file="data/Source_Classification_Code.rds")
#scc <- tbl_df(scc)


#scc2 <- filter(scc, grepl("Vehicle", EI.Sector))

#nei_balt <- filter(nei, fips == "24510")
#neiscc2 <- merge(nei_balt, scc2, by="SCC")
#neiscc2_year <- group_by(neiscc2, year)
#neiscc2_sum <- summarise(neiscc2_yeae, tot_emissions = sum(Emissions))

##Get the data for Baltimore and type = ON-ROAD. The number of observations matched if we search
#for "Vehicle in the SCC EI.Sector and merge with the nei data. Hence just filtering the data 
#from the nei data set

nei2 <- filter(nei, fips == "24510" & type == "ON-ROAD")

nei2_year <- group_by(nei2, year)
nei2_sum <- summarise(nei2_year, tot_emissions = sum(Emissions))

##Make the variables factors for the graph to display properly
nei2_sum = transform(nei2_sum, year = factor(year))

png("plot5.png")

##create a chart for Total Emissions from On-Road Vehicles in Baltimore
g <- ggplot(nei2_sum, aes(x=year, y=tot_emissions)) + 
        geom_bar(fill = "Orange", stat="Identity") + 
        ylab("Total Emissions") + 
        ggtitle("Total Emissions from On-Road Vehicles in Baltimore") +
        geom_text(aes(label = round(tot_emissions)), y=50, size = 6) +
        theme(
                axis.text = element_text(size = 12),
                axis.title = element_text(size = 14)
                
        )
print(g)

dev.off()