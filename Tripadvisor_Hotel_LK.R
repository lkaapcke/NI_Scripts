# Script to scrape a Tripadvisor Hotel record

# Install rvest & load needed packages
#install.packages("rvest")
library(rvest)
library(tidyverse)
library(stringr)

# Read the hotel URL
tripadv_hotel <- read_html("https://www.tripadvisor.com/Hotel_Review-g34439-d10587631-Reviews-Urbanica_The_Meridian_Hotel-Miami_Beach_Florida.html")

tripadv_hotel_1 <- read_html("https://www.tripadvisor.com/Hotel_Review-g34439-d87028-Reviews-Eden_Roc_Miami_Beach_Resort-Miami_Beach_Florida.html")

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
reviews
reviews <- reviews[[1]][1]
reviews
num_reviews <- as.numeric(gsub(",", "", reviews[[1]][1]))
num_reviews

# Remove extraneous text
## TO DO: only do this if the number of reviews is longer than 2
reviews <- str_split(reviews[[1]][1], ",")
reviews
reviews <- paste(reviews[[1]][1], reviews[[1]][2], sep = "")
reviews

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

# Scrape the amenities
amenities_text <- tripadv_hotel_1 %>% 
  html_node(".hrAmenitiesSectionWrapper") %>% 
  html_text()
amenities_text

unavailable_amenities <- tripadv_hotel_1 %>% 
  html_nodes(".unavailable") %>% 
  html_text()
unavailable_amenities

amen <- tripadv_hotel %>% 
  html_nodes(".is-6-desktop") %>% 
  html_text
amen <- sort(amen, decreasing = F, na.last = T)

no_amen <- tripadv_hotel %>% 
  html_nodes(".unavailable") %>% 
  html_text()
no_amen




# Collect all this information in a data frame:
hotel_record <- data.frame(Hotel_Name = hotel_name,
                           Street_Address = street_address,
                           City_State_Zip = locality,
                           Guest_Rating = rating,
                           Number_Reviews = num_reviews,
                           Pool = pool)
hotel_record
View(hotel_record)

# Extract price

content <- tripadv_hotel %>%
  html_nodes(".sub_content") %>% 
  html_text
content

cont_1 <- tripadv_hotel %>%
  html_nodes(".is-shown-at-desktop") %>% 
  html_text
cont_1

str_detect(content, "(Based on Average Rates for a Standard Room)")
regexpr("(Based on Average Rates for a Standard Room)", content)
gregexpr("(Based on Average Rates for a Standard Room)", content)
