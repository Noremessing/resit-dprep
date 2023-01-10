library(readr)
library(ggplot2)
## 2.1 CREATE HISTOGRAM

df_listings_merged <- read_csv("gen/analysis/temp/df_listings_merged.csv")
dir.create('gen')
dir.create('gen/paper')
dir.create('gen/paper/output')

pdf("gen/paper/output/histogram.pdf")
hist(df_listings_merged$num_reviews,
     main = "The distribution of the number of reviews per listing\nwhere number of reviews is between 2 and 100",
     xlab = "Number of reviews",
     col = "gray",
     breaks="FD",
     prob = TRUE)

lines(density(df_listings_merged$num_reviews), col="red")
dev.off()
