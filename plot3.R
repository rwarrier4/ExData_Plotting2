library(dplyr)
library(ggplot2)

##Load the nei data to a data frame from the file
nei <- readRDS(file="data/summarySCC_PM25.rds")
nei <- tbl_df(nei)

##Filter Baltimore data
balt <- filter(nei, fips == "24510")


##Group by both year and type
balt_type <- group_by(balt, year, type)

##summarize the data to calculate the total emissions by year
balt_sum <- summarise(balt_type, tot_emissions = sum(Emissions))

##Make the variables factors for the graph to display properly
balt_sum = transform(balt_sum, type = factor(type))
balt_sum = transform(balt_sum, year = factor(year))

png("plot3.png")

##create a chart for each type for Baltimore city
g <- ggplot(balt_sum, aes(x=year, y=tot_emissions, group=type)) + facet_wrap(~type, nrow=2) + 
        geom_point(color="#330000") + geom_line(size = 1, color="#D55E00") + ylab("Total Emissions") +
        ggtitle("Baltimore Emissions by Type") +
        geom_text(aes(label=round(tot_emissions)),hjust=0, vjust=0, size=4) +
        theme(
                axis.text = element_text(size = 12),
                panel.grid.major = element_line(colour = "grey40"),
                panel.grid.minor = element_blank(),
                panel.background = element_rect(fill = "#56B4E9")
        )

print(g)

dev.off()