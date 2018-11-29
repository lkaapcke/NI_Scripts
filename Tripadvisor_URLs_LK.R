## Tripadvisor Script to gather URLs
## Goal: Get script to collect URLs and put in a df

## Load libraries
library(tidyverse)
library(rvest)
library(magrittr)
library(stringr)

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

#Read the URLs for each hotel from the page
urls_html <- webpage %>%
    html_nodes(".prominent") %>% 
    html_attr('href')
urls_html

# Write a loop to record this information for all pages
#Define empty DF

hotel_urls_df <- data.frame(Hotel_URL = NA)

for (page in 1:last_page) {
  
  # Iterate URL
  url <- paste("https://www.tripadvisor.com/Hotels-g34439-oa",(page-1)*30,"-Miami_Beach_Florida-Hotels.html", sep ="")
  
  # Read code from the site
  webpage <- read_html(url)
  
  # Number of results pages
  last_html <- html_nodes(webpage,'.last')
  
  #Read the URLs for each hotel from the page
  urls_html <- webpage %>%
    html_nodes(".prominent") %>% 
    html_attr('href')
  
  hotel_urls_df <- data.frame(Hotel_URL = urls_html)
  
  hotel_urls_df_page <- data.frame(Hotel_URL = urls_html)
  
  hotel_urls_df <- rbind(hotel_urls_df, hotel_urls_df_page)
}

hotel_urls_df <- drop_na(hotel_urls_df)
View(hotel_urls_df)

