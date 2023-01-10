library(dplyr)
library(tidyr)
library(readr)

## 1.2 FILTER AND MERGE DATA

reviews <- read_csv("data/reviews.csv")
listings <- read_csv("data/listings.csv")

# filter for reviews published since 2017
reviews_filtered <- reviews %>% filter(date >= "2017-01-01")

# filter for `listings` that have received at least x reviews.
listings_filtered <- listings %>% filter(number_of_reviews > 5)

# merge the `reviews` and `listings` dataframes on a common columns (the type of join doesn't really matter since we already filtered out listings without any reviews)
df_merged <- reviews_filtered %>% 
  left_join(listings_filtered, by = c("listing_id" = "id"))

# group the number of reviews by listing (1)
df_listings_merged <- df_merged %>% group_by(listing_id) %>% summarise(num_reviews = n()) %>% arrange(desc(num_reviews)) %>% filter(num_reviews <= 100)

dir.create('gen')
dir.create('gen/analysis')
dir.create('gen/analysis/temp')
write.csv(df_listings_merged, "gen/analysis/temp/df_listings_merged.csv")
