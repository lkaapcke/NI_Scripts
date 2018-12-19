## Tripadvisor Script for an individual hotel page
## Code without loop

## Load libraries
library(tidyverse)
library(rvest)
library(magrittr)
library(stringr)

#Import data needed:
URLs_MB <- read_csv("~/Tripadvisor Scraping/URLs_MB.csv")
URLs_KW <- read_csv("~/Tripadvisor Scraping/URLs_KW.csv")
URLs_test <- read_csv("~/Tripadvisor Scraping/URLs_test.csv")
#View(URLs_test)
#View(URLs_KW)

# How many hotels to collect data for?
length(URLs_test$Complete_URL)

# Create a blank df to be filled later:
hotel_data <- data.frame(Hotel_Name = NA)

for (i in 1:length(URLs_test$Complete_URL)) {

  url_1 <- paste(URLs_test$Complete_URL)[i]
  #url_1
  
# Scrape data for an individual hotel
#url_1 <- paste("https://www.tripadvisor.com/Hotel_Review-g34439-d1200086-Reviews-Grand_Beach_Hotel-Miami_Beach_Florida.html", sep ="")
#url_1

# Read the HTML code from the site
hotel_url <- read_html(url_1)

# Pull hotel name
name <- html_text(html_nodes(hotel_url, '#HEADING'))
#name

# Pull hotel address
address_info <- html_text(html_nodes(hotel_url, '.address .detail'))
#address_info

# Pull hotel rating
rating <- as.numeric(str_trim(html_text(html_nodes(hotel_url,'.hotels-hotel-review-about-with-photos-Reviews__overallRating--3cjYf')), side = "both"))
#rating

# Scrape info from bottom of page to mine for prices and number of rooms
more_info <- html_text(html_nodes(hotel_url, '.hotels-hotel-review-layout-Section__plain--1HV0a'))
more_info

# Extract prices
price_low <- as.numeric(str_extract(str = more_info, pattern = "[:digit:]+"))
price_high <- strsplit(strsplit(more_info, "\\$")[[1]][3], " ")[[1]][1]
price_high <- gsub(",", "", price_high)
price_high <- as.numeric(price_high)

#price_low
#price_high

#Extract number of rooms
num_rooms <- as.numeric(str_extract(str = substr(more_info, nchar(more_info)-6, nchar(more_info)), pattern = "[:digit:]+"))
#num_rooms

# Scrape for matching nodes, the third one contains hotel class data
stars <- as.character(html_nodes(hotel_url, '.is-6+ .is-6 .hotels-hotel-review-about-with-photos-layout-TextItem__textitem--3CMuR')[3])
#stars

# Extract hotel class
hotel_class <- as.numeric(paste(substr(str_extract(stars, pattern = "_[:digit:]+"), 2, 2), ".", substr(str_extract(stars, pattern = "_[:digit:]+"), 3, 3), sep = ""))
#hotel_class

# Collect all the scraped data into a df

hotel_scrape <- data.frame(Hotel_Name = name)

hotel_data <- rbind(hotel_data, hotel_scrape)

}

###############################

data_df <- drop_na(hotel_data)
View(hotel_data)

# To Do:
# Put everthing into a df
# Create loop to do this to every URL in a different df
