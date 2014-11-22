library(ggplot2)
library(dplyr)

nei <- readRDS(file="data/summarySCC_PM25.rds")
nei <- tbl_df(nei)


nei_balt_la <- filter(nei, fips == "24510" | fips == "06037")
nei_year <- group_by(nei_balt_la, year, fips)

nei_sum <- summarise(nei_year, tot_emissions = sum(Emissions))

nei_sum <- mutate(nei_sum, county= ifelse(fips == "24510", "Baltimore", "LA"))

##Make the variables factors for the graph to display properly
nei_sum = transform(nei_sum, year = factor(year))

png("exdata-008/ExData_Plotting2/plot6.png")

cbbPalette <- c("#0072B2", "#D55E00", "#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#CC79A7")

##create a chart comparing Total Emissions in LA vs Baltimore over from 1999 to 2008
g <- ggplot(nei_sum, aes(x=year, y=tot_emissions, ymax=50000)) + 
        geom_bar(aes(fill=county), color="black", stat="Identity", position = 'dodge') + 
        geom_text(aes(group = county, label = round(tot_emissions)), 
                  position = position_dodge(width=0.9), size = 4, vjust=-0.5) +
        ylab("Total Emissions") + scale_fill_manual(values=cbbPalette) +
        ggtitle("Total Emissions - Baltimore vs LA") +
        theme(
                axis.text = element_text(size = 12),
                axis.title = element_text(size = 14)
                
        )
        
print(g) 

dev.off()