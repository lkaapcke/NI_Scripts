## Tripadvisor Script to gather URLs
## Goal: Get script to collect URLs and put in a df

## Load libraries
library(tidyverse)
library(rvest)
library(magrittr)
library(stringr)
#library(Rcrawler)

# URL we want to scrape
url <- 'https://www.tripadvisor.com/Hotels-g34439-oa0-Miami_Beach_Florida-Hotels.html'

# Read the HTML code from the site
webpage <- read_html(url)

# Number of results pages
last_html <- html_nodes(webpage,'.last')

# Convert to a number
last_text <- html_text(last_html)
last_page <- as.numeric(last_text)
last_page

# Try using Rcrawler?
#Rcrawler(Website = "https://www.tripadvisor.com/Hotels-g34439-Miami_Beach_Florida-Hotels.html", no_cores = 4, no_conn = 4)

# Write a loop to find this information for all pages

# Define empty DF



hotel_urls_df <- data.frame(Hotel_URL = NA)

for (page in 1:last_page) {

# Iterate URL
url <- paste("https://www.tripadvisor.com/Hotels-g34439-oa",(page-1)*30,"-Miami_Beach_Florida-Hotels.html", sep ="")

# Read the HTML code from the site
webpage <- read_html(url)

# Number of results pages
last_html <- html_nodes(webpage,'.last')

# Collect URL
#hotel_names_html <- html_nodes(webpage,'.prominent')
#hotel_url_html <- html_nodes(webpage,)

# Now convert to text
#hotel_names <- html_text(hotel_names_html)
#hotel_review_counts <- html_text(hotel_review_count_html)
#hotel_prices <- html_text(hotel_prices_html)
#hotel_prices_full <- c(hotel_prices, rep(NA, length(hotel_names) - length(hotel_prices)))
#hotel_ratings <- html_text(hotel_ratings_html)

# Combine data into a dataframe
#hotel_info_df <- data.frame(HotelName = hotel_names, NumberReviews = hotel_review_counts, Price = hotel_prices)
#hotel_info_df

#hotel_info_df_page <- data.frame(HotelName = hotel_names,
#NumberReviews = hotel_review_counts,
#Price = hotel_prices_full)

#hotel_info_df <- rbind(hotel_info_df, hotel_info_df_page)
#}

#hotel_info_df <- drop_na(hotel_info_df)
#View(hotel_info_df)