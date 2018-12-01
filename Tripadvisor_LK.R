## Tripadvisor Script
## Code without loop

## Load libraries
library(tidyverse)
library(rvest)
library(magrittr)
library(stringr)

#Scrape data for an individual hotel

url_1 <- paste("https://www.tripadvisor.com/Hotel_Review-g34439-d247106-Reviews-SBH_South_Beach_Hotel-Miami_Beach_Florida.html", sep ="")

# Read the HTML code from the site
hotel_url <- read_html(url_1)

name <- html_text(html_nodes(hotel_url, '#HEADING')) 
amenities <- html_text(html_nodes(hotel_url,'.is-6-desktop .textitem')) 
unavail_amenities <- html_text(html_nodes(hotel_url,'.is-6-desktop .unavailable'))
rating <- html_text(html_nodes(hotel_url,'.overallRating'))
address_info <- html_text(html_nodes(hotel_url, '.public-business-listing-ContactInfo__nonWebLink--1EqMn span'))
address <- address_info[1]
hotel_info_html <- html_nodes(hotel_url, '.is-shown-at-desktop .section_content')
hotel_info <- html_text(hotel_info_html)
hotel_info
low_price <- as.numeric(str_extract(str = str_extract(string = hotel_info,
                                                      pattern = "\\$[:digit:]+"), pattern = "[:digit:]+"))

high_price <- as.numeric(str_extract(str = str_extract(string = hotel_info,
                                                       pattern = "-[:blank:]\\$[:digit:]+"), pattern = "[:digit:]+"))

# Extract string containing number of hotel rooms
hotel_rooms <- substr(hotel_info, regexpr('Number of rooms', hotel_info)+15, regexpr('Number of rooms', hotel_info)+18)

# Isolate the number and change to numeric
number_rooms <- as.numeric(substr(hotel_rooms, 0, regexpr('P', hotel_rooms)-1))
number_rooms

# Extract Number of rooms and Price range from hotel info
hotel_info <- html_text(hotel_info_html)
hotel_info

# To Do:
# Extract hotel class
# Put everthing into a df
# Create loop to do this to every URL in a sheet
# Fix issue with hotel_info



























