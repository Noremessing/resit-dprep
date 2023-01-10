library(tidyverse)

# 1 DATA PREPARATION

## 1.1 DOWNLOAD THE DATA

get_data <- function(url, filename){
  download.file(url = url, destfile = paste0(filename, ".csv"))
}

url_listings <- "http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2022-06-05/visualisations/listings.csv"
url_reviews <- "http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2022-06-05/visualisations/reviews.csv"

get_data(url_listings, "listings")
get_data(url_reviews, "reviews")

## 1.2 FILTER AND MERGE DATA

reviews <- read_csv("reviews.csv")
listings <- read_csv("listings.csv")

# filter for reviews published since 2017
reviews_filtered <- reviews %>% filter(date >= "2017-01-01")

# filter for `listings` that have received at least x reviews.
listings_filtered <- listings %>% filter(number_of_reviews > 5)

# merge the `reviews` and `listings` dataframes on a common columns (the type of join doesn't really matter since we already filtered out listings without any reviews)
df_merged <- reviews_filtered %>% 
  left_join(listings_filtered, by = c("listing_id" = "id"))

# group the number of reviews by listing (1)
df_listings_merged <- df_merged %>% group_by(listing_id) %>% summarise(num_reviews = n()) %>% arrange(desc(num_reviews)) %>% filter(num_reviews <= 100)

## 1.3 AGGREGATE THE DATA 

# group the number of reviews by month and neighborhood group.(2)
df_aggregated <- df_merged %>%
  mutate(month = format(date, "%m"), year = format(date, "%Y")) %>%
  group_by(year, month, neighbourhood) %>%
  summarise(num_reviews = n())

# create date column
df_aggregated$date <- as.Date(paste0(df_aggregated$year, "-", df_aggregated$month, "-01"))

# 2.0 REPORTING

## 2.1 CREATE HISTOGRAM

# import the relevant dataset

pdf("histogram.pdf")
hist(df_listings_merged$num_reviews,
     main = "The distribution of the number of reviews per listing\nwhere number of reviews is between 2 and 100",
     xlab = "Number of reviews",
     col = "gray",
     breaks="FD",
     prob = TRUE)

lines(density(df_listings_merged$num_reviews), col="red")
dev.off()

# 2.2 CREATE LINE PLOT

# convert the `date` column into date format.
df_aggregated$date <- as.Date(df_aggregated$date)

# group by date and calculate the sum of all reviews across neighbourhood groups.
df_groupby <- df_aggregated %>% group_by(date) %>% summarise(num_reviews = sum(num_reviews))

# plot the chart and store the visualisation.
pdf("plot.pdf")
plot(x = df_groupby$date, 
     y = df_groupby$num_reviews, 
     type = "l", 
     xlab = "",
     ylab = "Total number of reviews", 
     main = "Effect of COVID-19 pandemic\non Airbnb review count")
dev.off()

