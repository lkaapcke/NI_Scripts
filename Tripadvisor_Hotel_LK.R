# Script to scrape a Tripadvisor Hotel record

# Install rvest & load needed packages
install.packages("rvest")
library(rvest)
library(tidyverse)
library(stringr)

# Read the hotel URL
tripadv_hotel <- read_html("https://www.tripadvisor.com/Hotel_Review-g34439-d80247-Reviews-Holiday_Inn_Miami_Beach-Miami_Beach_Florida.html")

# Scrape the hotel name
hotel_name <- tripadv_hotel %>% 
  html_node("#HEADING") %>% 
  html_text()
hotel_name

# Scrape the hotel street address
street_address <- tripadv_hotel %>% 
  html_node(".street-address") %>% 
  html_text()
street_address

# Scrape the hotel locality
locality <- tripadv_hotel %>% 
  html_node(".locality") %>% 
  html_text()
locality

# Scrape the hotel rating
rating <- tripadv_hotel %>%
  html_nodes(".overallRating") %>% 
  html_text() %>% 
  str_trim() %>% 
  as.numeric()
rating

# Scrape the number of reviews
reviews <- tripadv_hotel %>% 
  html_node(".reviewCount") %>% 
  html_text() %>% 
  str_split(" ")

# Remove extraneous text
## TO DO: only do this if the number of reviews is longer than 2
reviews <- str_split(reviews[[1]][1], ",")
reviews <- paste(reviews[[1]][1], reviews[[1]][2], sep = "")

# Change to a number
num_reviews <- as.numeric(reviews)
num_reviews

# Scrape description text for Number of rooms and price range
description <- tripadv_hotel %>% 
  html_nodes(".section_content") %>% 
  html_text
description

# Extract text with number of rooms
rm_position <- str_locate(description, "Number of rooms")
rm_position

# Subset text
rm_text <- str_sub(description, start = rk[[3]][1], end = rk[[3]][1]+20)
rm_text






