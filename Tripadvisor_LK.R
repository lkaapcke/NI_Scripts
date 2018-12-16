## Tripadvisor Script for an individual hotel page
## Code without loop

## Load libraries
library(tidyverse)
library(rvest)
library(magrittr)
library(stringr)

#Scrape data for an individual hotel
url_1 <- paste("https://www.tripadvisor.com/Hotel_Review-g34439-d1201317-Reviews-Riviera_Hotel_Suites_South_Beach-Miami_Beach_Florida.html", sep ="")

# Read the HTML code from the site
hotel_url <- read_html(url_1)

# Pull hotel name
name <- html_text(html_nodes(hotel_url, '#HEADING'))

# Pull hotel address
address_info <- html_text(html_nodes(hotel_url, '.public-business-listing-ContactInfo__nonWebLink--1EqMn span'))
address <- address_info[1]

# Pull hotel rating
rating <- as.numeric(str_trim(html_text(html_nodes(hotel_url,'.overallRating')), side = "both"))

# Scrape info from bottom of page to mine for prices and number of rooms
more_info <- html_text(html_nodes(hotel_url, '.ui_section'))

# Extract prices
price_low <- as.numeric(str_extract(str = more_info, pattern = "[:digit:]+"))
price_high <- as.numeric(str_extract(str = str_extract(string = more_info, 
                                                       pattern = "-[:blank:]\\$[:digit:]+"),
                                     pattern = "[:digit:]+"))

#Extract number of rooms
num_rooms <- as.numeric(str_extract(str = substr(more_info, nchar(more_info)-6, nchar(more_info)), pattern = "[:digit:]+"))

# Scrape for matching nodes, the third one contains hotel class data
stars <- as.character(html_nodes(hotel_url, '.is-6+ .is-6 .hotels-hotel-review-about-with-photos-layout-TextItem__textitem--3CMuR')[3])

# Extract hotel class
hotel_class <- paste(substr(str_extract(stars, pattern = "_[:digit:]+"), 2, 2), ".", substr(str_extract(stars, pattern = "_[:digit:]+"), 3, 3), sep = "")

# Collect all the scraped data into a df

hotel_scrape <- data.frame(Hotel_Name = name,
                          Address = address,
                          Rating = rating,
                          Low_Price = price_low,
                          High_Price = price_high,
                          Number_Rooms = num_rooms,
                          Hotel_Class = hotel_class,)

View(hotel_scrape)

# To Do:
# Put everthing into a df
# Create loop to do this to every URL in a different df
