emissions data and classification code
emissions_data 
<- readRDS("summarySCC_PM25.rds")
class_code 
<- readRDS("Source_Classification_Code.rds")

## records with coal
coal_class_code <- class_code[grepl("Coal", class_code$Short.Name), ]
coal_emissions_data <- emissions_data[emissions_data$SCC %in% coal_class_code$SCC, ]

## total emissions by year
coal_emissions_year <- aggregate(coal_emissions_data$Emissions, 
                                 by=list(coal_emissions_data$year), FUN=sum)
colnames(coal_emissions_year) 
<- c("year", "emissions")

## coal related emissions across the US from 1999-2008
png(filename = "plot4.png")
plot(coal_emissions_year$year, coal_emissions_year$emissions, type = "o",
     xlab = "Year",
     ylab = "Total Emissions (tons)",
     main = "Coal Related Emissions of PM2.5 in US from 1999-2008")
