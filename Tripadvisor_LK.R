## Tripadvisor Script
## Code without loop

## Load libraries
library(tidyverse)
library(rvest)

# URL we want to scrape
url <- 'https://www.tripadvisor.com/Hotels-g34439-oa0-Miami_Beach_Florida-Hotels.html'

# Read the HTML code from the site
webpage <- read_html(url)

# Number of results pages
last_html <- html_nodes(webpage,'.last')

#Convert to a number
last_text <- html_text(last_html)
last_page <- as.numeric(last_text)
#last_page

# Now what data to scrape? Hotel name, review count, hotel price, rating
hotel_names_html <- html_nodes(webpage,'.prominent')
hotel_review_count_html <- html_nodes(webpage, '.review_count')
hotel_prices_html <- html_nodes(webpage, '.price-wrap .price')
#hotel_ratings_html <- html_nodes(webpage,'.ui_bubble_rating') Script cannot scrape this because it is a picture

# Now convert to text
hotel_names <- html_text(hotel_names_html)
hotel_review_counts <- html_text(hotel_review_count_html)
hotel_prices <- html_text(hotel_prices_html)
#hotel_ratings <- html_text(hotel_ratings_html)

# Combine data into a dataframe
hotel_info_df <- data.frame(HotelName = hotel_names, NumberReviews = hotel_review_counts, Price = hotel_prices)
hotel_info_df


##########################################################
#Attempting to write a loop for this code:

# Write a loop to find this information for all pages

for (page in 1:last_page) {
  
  # Iterate URL
  url <- paste("https://www.tripadvisor.com/Hotels-g34439-oa",(page-1)*30,"-Miami_Beach_Florida-Hotels.html", sep ="")
  
  # Read the HTML code from the site
  webpage <- read_html(url)
  
  # Number of results pages
  last_html <- html_nodes(webpage,'.last')

  # Now what data to scrape? Hotel name, review count, hotel price, rating
  hotel_names_html <- html_nodes(webpage,'.prominent')
  hotel_review_count_html <- html_nodes(webpage, '.review_count')
  hotel_prices_html <- html_nodes(webpage, '.price-wrap .price')
  #hotel_ratings_html <- html_nodes(webpage,'.ui_bubble_rating') Script cannot scrape this   because it is a picture

  # Now convert to text
  hotel_names <- html_text(hotel_names_html)
  hotel_review_counts <- html_text(hotel_review_count_html)
  hotel_prices <- html_text(hotel_prices_html)
  #hotel_ratings <- html_text(hotel_ratings_html)

  # Combine data into a dataframe
  #hotel_info_df <- data.frame(HotelName = hotel_names, NumberReviews = hotel_review_counts, Price = hotel_prices)
  #hotel_info_df

}

hotel_info_df <- data.frame(HotelName = hotel_names, NumberReviews = hotel_review_counts, Price = hotel_prices)
hotel_info_df
