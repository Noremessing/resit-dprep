library(tidyverse)
# 2.2 CREATE LINE PLOT

df_aggregated <- read_csv("gen/analysis/temp/df_aggregated.csv")
# convert the `date` column into date format.
df_aggregated$date <- as.Date(df_aggregated$date)

# group by date and calculate the sum of all reviews across neighbourhood groups.
df_groupby <- df_aggregated %>% group_by(date) %>% summarise(num_reviews = sum(num_reviews))

# plot the chart and store the visualisation.
pdf("gen/paper/output/plot.pdf")
plot(x = df_groupby$date, 
     y = df_groupby$num_reviews, 
     type = "l", 
     xlab = "",
     ylab = "Total number of reviews", 
     main = "Effect of COVID-19 pandemic\non Airbnb review count")
dev.off()
