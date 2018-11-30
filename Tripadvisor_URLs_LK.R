## Tripadvisor Script to gather URLs
## Goal: Get script to collect URLs and put in a df

## Load libraries
library(tidyverse)
library(rvest)
library(magrittr)
library(stringr)
library(rlist)

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

# Create an empty data fram where URLs will be stored
blank_df <- data.frame(Hotel_URL = NA)

for (page in 1:last_page) {
  
  # Iterate URL
  url <- paste("https://www.tripadvisor.com/Hotels-g34439-oa",(page-1)*30,"-Miami_Beach_Florida-Hotels.html", sep ="")
  url
  
  # Read code from the site
  webpage <- read_html(url)
  
  # Number of results pages
  #last_html <- html_nodes(webpage,'.last')
  #last_html
  
  #Read the URLs for each hotel from the page
  urls_html <- webpage %>%
    html_nodes(".prominent") %>% 
    html_attr('href')
  urls_html
  
  df_urls <- data.frame(Hotel_URL = urls_html)
  df_urls
  
  blank_df <- rbind(blank_df, df_urls)
}

urls_df <- drop_na(blank_df)
View(urls_df)

#complete_urls_df <- data.frame(Complete_URL = paste(urls_df$Hotel_URL, "https://www.tripadvisor.com", sep = ""))
#View(complete_urls_df)

# To do: concatenate every row with the beginning of the url
# Try looking here: https://stackoverflow.com/questions/13944078/concatenate-rows-of-a-data-frame









