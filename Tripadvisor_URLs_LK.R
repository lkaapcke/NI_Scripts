## Tripadvisor Script to gather URLs

## Load libraries
library(tidyverse)
library(rvest)
library(magrittr)
library(stringr)

# URL we want to scrape
url <- 'https://www.tripadvisor.com/Hotels-g34439-oa0-Miami_Beach_Florida-Hotels.html'

# Split the URL before the page iterator
beg_url <- "https://www.tripadvisor.com/Hotels-g34439-oa"

# And after the page iterator
end_url <- "-Miami_Beach_Florida-Hotels.html"

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
  url <- paste(beg_url, (page-1)*30, end_url, sep ="")
  
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
#View(urls_df)

# Concatenate every row to create the complete URL and put that in a new df

all_urls <- data.frame(Complete_URL = NA)

for (row in 1:nrow(urls_df)) {
  url <- urls_df[row, "Hotel_URL"]
  
  complete_url <- paste("https://www.tripadvisor.com", url, sep = "")
  
  whole_url <- data.frame(Complete_URL = complete_url)
  all_urls <- rbind(all_urls, whole_url)
}

all_urls <- drop_na(all_urls)

# Export a CSV with the URLs you need
write.csv(all_urls, file = "All_URLS.csv")

# To Dos:
# Make this into a function that returns a df (and/or csv)

