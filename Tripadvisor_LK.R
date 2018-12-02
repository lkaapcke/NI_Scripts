## Tripadvisor Script
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

name <- html_text(html_nodes(hotel_url, '#HEADING')) # good

address_info <- html_text(html_nodes(hotel_url, '.public-business-listing-ContactInfo__nonWebLink--1EqMn span'))
address <- address_info[1] # good

#amenities <- html_text(html_nodes(hotel_url,'.is-6-desktop .textitem'))
amenities <- html_text(html_nodes(hotel_url, ".hotels-hotel-review-about-with-photos-layout-Group__group--KGq7E:nth-child(1) .hotels-hotel-review-about-with-photos-AmenityGroup__amenitiesList--1kgjY"))
amenities
#amenities <- html_text(html_nodes(hotel_url, '.hotels-hotel-review-about-with-photos-AmenitiesModal__group--1PHad'))
#amenities

#unavail_amenities <- html_text(html_nodes(hotel_url,'.is-6-desktop .unavailable'))
#unavail_amenities

rating <- str_trim(html_text(html_nodes(hotel_url,'.hotels-hotel-review-about-with-photos-Reviews__overallRating--3cjYf')), side = "both") # good

#hotel_info_html <- html_nodes(hotel_url, '.is-shown-at-desktop .section_content')
#hotel_info <- html_text(hotel_info_html)
#hotel_info

#low_price <- as.numeric(str_extract(str = str_extract(string = hotel_info,
                                                      #pattern = "\\$[:digit:]+"), pattern = "[:digit:]+"))

#high_price <- as.numeric(str_extract(str = str_extract(string = hotel_info,
                                                       #pattern = "-[:blank:]\\$[:digit:]+"), #pattern = "[:digit:]+"))

# Extract string containing number of hotel rooms
hotel_rooms <- substr(hotel_info, regexpr('Number of rooms', hotel_info)+15, regexpr('Number of rooms', hotel_info)+18)

# Isolate the number and change to numeric
number_rooms <- as.numeric(substr(hotel_rooms, 0, regexpr('P', hotel_rooms)-1))
number_rooms

# Extract Number of rooms and Price range from hotel info
hotel_info <- html_text(hotel_info_html)
hotel_info



num_rooms <- as.numeric(html_text(html_nodes(hotel_url, '.hotels-hotel-review-about-addendum-AddendumItem__item--3cmiZ:nth-child(4) .hotels-hotel-review-about-addendum-AddendumItem__content--28NoV')))

more_info <- html_text(html_nodes(hotel_url, '.hotels-hotel-review-layout-Section__plain--1HV0a'))

price_low <- as.numeric(str_extract(str = more_info, pattern = "[:digit:]+"))
price_high <- as.numeric(str_extract(str = str_extract(string = more_info, 
                                                       pattern = "-[:blank:]\\$[:digit:]+"),
                                     pattern = "[:digit:]+"))

num_rooms <- as.numeric(str_extract(str = substr(more_info, nchar(more_info)-6, nchar(more_info)), pattern = "[:digit:]+"))




# To Do:
# Extract hotel class
# Put everthing into a df
# Create loop to do this to every URL in a sheet
# Fix issue with hotel_info
# <span class="ui_star_rating star_40 hotels-hotel-review-about-with-photos-goodtoknow-StarRating__stars--cwu1U"></span>

stars <- as.character(html_nodes(hotel_url, '.is-6+ .is-6 .hotels-hotel-review-about-with-photos-layout-TextItem__textitem--3CMuR')[3])

hotel_class <- paste(substr(str_extract(stars, pattern = "_[:digit:]+"), 2, 2), ".", substr(str_extract(stars, pattern = "_[:digit:]+"), 3, 3), sep = "")
hotel_class
























