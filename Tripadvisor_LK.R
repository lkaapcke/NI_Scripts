## Tripadvisor Script
## Code without loop

## Load libraries
library(tidyverse)
library(rvest)
library(magrittr)
library(stringr)

# URL we want to scrape
#url <- 'https://www.tripadvisor.com/Hotels-g34439-oa0-Miami_Beach_Florida-Hotels.html'

# Read the HTML code from the site
#webpage <- read_html(url)

# Number of results pages
#last_html <- html_nodes(webpage,'.last')

#Convert to a number
#last_text <- html_text(last_html)
#last_page <- as.numeric(last_text)
#last_page

# Write a loop to find this information for all pages

# Define empty DF

#hotel_info_df <- data.frame(HotelName = NA,
                            #NumberReviews = NA,
                            #Price = NA)

#for (page in 1:last_page) {
  
  # Iterate URL
  #url <- paste("https://www.tripadvisor.com/Hotels-g34439-oa",(page-1)*30,"-Miami_Beach_Florida-Hotels.html", sep ="")
  
  # Read the HTML code from the site
  #webpage <- read_html(url)
  
  # Number of results pages
  #last_html <- html_nodes(webpage,'.last')
  
  # Now what data to scrape? Hotel name, review count, hotel price, rating
  #hotel_names_html <- html_nodes(webpage,'.prominent')
  #hotel_review_count_html <- html_nodes(webpage, '.review_count')
  #hotel_prices_html <- html_nodes(webpage, '.price-wrap .price')
  #hotel_ratings_html <- html_nodes(webpage,'.ui_bubble_rating') Script cannot scrape this   because it is a picture
  
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


#Scrape data for an individual hotel

url_1 <- paste("https://www.tripadvisor.com/Hotel_Review-g34439-d209406-Reviews-The_Ritz_Carlton_South_Beach-Miami_Beach_Florida.html", sep ="")

# Read the HTML code from the site
hotel_url <- read_html(url_1)

amenities_html <- html_nodes(hotel_url,'.is-6-desktop .textitem')
unavailable_html <- html_nodes(hotel_url,'.is-6-desktop .unavailable')
#hotel_class_html <- html_nodes(hotel_url,'.prw_common_info_bubble+ .sub_content')
rating_html <- html_nodes(hotel_url,'.overallRating')
hotel_info_html <- html_nodes(hotel_url, '.is-shown-at-desktop .section_content')

amenities <- html_text(amenities_html) # Give list of amenities, but includes amenities a hotel doesn't have
unavailable_amenities <- html_text(unavailable_html)
hotel_class <- html_text(hotel_class_html)
#number_rms <- html_text(number_rms_html) 
#price_range <- html_text(price_range_html)
rating <- html_text(rating_html)

# Extract Number of rooms and Price range from hotel info
hotel_info <- html_text(hotel_info_html)
hotel_info

hotel_rooms <- substr(hotel_info, regexpr('Number of rooms', hotel_info)+15, regexpr('Number of rooms', hotel_info)+18)

price_range <- substr(hotel_info, regexpr('Price range', hotel_info)+12, regexpr('Price range', hotel_info)+23)
price_range

# Extract low and high price from the price range
# TO DO: Check that this works for hotels with any price

str_split(price_range, " ")
low_price <- as.numeric(str_split(price_range, " ")[[1]][1])
low_price

high_price <- gsub(",", "", substr(str_split(price_range, " ")[[1]][3], 2, 10))
high_price

#amenities
#unavailable_amenities
#hotel_class #edit
#rating








