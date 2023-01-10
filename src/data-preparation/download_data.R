library(tidyverse)
library(R.utils)

# 1 DATA PREPARATION

## 1.1 DOWNLOAD THE DATA

get_data <- function(url, filename){
  download.file(url = url, destfile = paste0(filename, ".csv"))
}

url_listings <- "http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2022-06-05/visualisations/listings.csv"
url_reviews <- "http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2022-06-05/visualisations/reviews.csv"

dir.create('data')
get_data(url_listings, "data/listings")
get_data(url_reviews, "data/reviews")
