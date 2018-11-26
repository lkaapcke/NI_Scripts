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

name_html <- html_nodes(hotel_url, '#HEADING')
amenities_html <- html_nodes(hotel_url,'.is-6-desktop .textitem')
unavailable_html <- html_nodes(hotel_url,'.is-6-desktop .unavailable')
#hotel_class_html <- html_nodes(hotel_url,'.prw_common_info_bubble+ .sub_content')
rating_html <- html_nodes(hotel_url,'.overallRating')
hotel_info_html <- html_nodes(hotel_url, '.is-shown-at-desktop .section_content')

hotel_name <- html_text(name_html)
amenities <- html_text(amenities_html) # Give list of amenities, but includes amenities a hotel doesn't have
unavailable_amenities <- html_text(unavailable_html)
hotel_class <- html_text(hotel_class_html)
rating <- html_text(rating_html)

# Extract Number of rooms and Price range from hotel info
hotel_info <- html_text(hotel_info_html)
hotel_info

# Extract string containing number of hotel rooms

hotel_rooms <- substr(hotel_info, regexpr('Number of rooms', hotel_info)+15, regexpr('Number of rooms', hotel_info)+18)

# Isolate the number and change to numeric
number_rooms <- as.numeric(substr(hotel_rooms, 0, regexpr('P', hotel_rooms)-1))

# Extract lower and upper price range

price_range <- substr(hotel_info, regexpr('Price range', hotel_info)+12, regexpr('Price range', hotel_info)+23)
#price_range

# Extract low and high price from the price range
# TO DO: Check that this works for hotels with any price (it should)

str_split(price_range, " ")
low_price <- as.numeric(str_split(price_range, " ")[[1]][1])
#low_price

high_price <- as.numeric(gsub(",", "", substr(str_split(price_range, " ")[[1]][3], 2, 10)))
#high_price

#amenities
#unavailable_amenities
#hotel_class #edit
#rating

# Edited price code from JC that only extracts digits 

char <- c("Price Range $58 - $120Room Type", "Price Range $57 - $1200Room Type")

low_price <- as.numeric(str_extract(string = char,
                                    pattern = "[:digit:]+"))

high_price <- as.numeric(str_extract(str = str_extract(string = char,
                                                       pattern = "-[:blank:]\\$[:digit:]+"), pattern = "[:digit:]+"))

# class = ui_star_rating star_50

class_html <- html_nodes(hotel_url,'.ui_star_rating')
class_text <- html_text(class_html)
class_text


























