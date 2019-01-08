# This is a function to retrieve hotel data from a tripadvisor hotel description page.

# Load libraries
library(rvest)
library(tidyverse)
library(stringr)
library(plyr)

get_hotel_record <- function(tripadv_hotel){
  # Scrape the hotel name
  hotel_name <- tripadv_hotel %>% 
    html_node("#HEADING") %>% 
    html_text()
  #hotel_name
  
  # Scrape the hotel street address
  street_address <- tripadv_hotel %>% 
    html_node(".street-address") %>% 
    html_text()
  #street_address
  
  # Scrape the hotel locality
  locality <- tripadv_hotel %>% 
    html_node(".locality") %>% 
    html_text()
  #locality
  
  # Scrape the hotel rating
  rating <- tripadv_hotel %>%
    html_nodes(".overallRating") %>%
    html_text() %>%
    str_trim() %>%
    as.numeric()
  #rating
  
  # Scrape the number of reviews
  reviews <- tripadv_hotel %>% 
    html_node(".reviewCount") %>% 
    html_text() %>% 
    str_split(" ")
  #reviews
  
  # Remove any commas and change this to a number
  num_reviews <- as.numeric(gsub(",", "", reviews[[1]][1]))
  #num_reviews
  
  # Scrape the amenities
  amenities <- tripadv_hotel %>% 
    html_nodes(".is-6-desktop") %>% 
    html_text
  amenities
  
  # Scrape the amenities that are not available
  not_amenities <- tripadv_hotel %>% 
    html_nodes(".unavailable") %>% 
    html_text()
  not_amenities
  
  # Test for each amenity with nested if statements
  if ("Pool" %in% not_amenities) {
    pool = 0
  } else {
    if("Pool" %in% amenities) {
      pool = 1
    } else {
      pool = 0
    }
  }
  pool
  
  # Bar/Lounge
  if ("Bar/Lounge" %in% not_amenities) {
    bar = 0
  } else {
    if("Bar/Lounge" %in% amenities) {
      bar = 1
    } else {
      bar = 0
    }
  }
  bar
  
  # Business Center
  if ("Business Center with Internet Access" %in% not_amenities) {
    biz_center = 0
  } else {
    if("Business Center with Internet Access" %in% amenities) {
      biz_center = 1
    } else {
      biz_center = 0
    }
  }
  biz_center
  
  # Conference Facilities
  if ("Conference Facilities" %in% not_amenities) {
    conference = 0
  } else {
    if("Conference Facilities" %in% amenities) {
      conference = 1
    } else {
      conference = 0
    }
  }
  conference

  # Meeting rooms
  if ("Meeting Rooms" %in% not_amenities) {
    meeting = 0
  } else {
    if("Meeting Rooms" %in% amenities) {
      meeting = 1
    } else {
      meeting = 0
    }
  }
  meeting
  
  # Wheelchair Access
  if ("Wheelchair access" %in% not_amenities) {
    wheelchair = 0
  } else {
    if("Wheelchair access" %in% amenities) {
      wheelchair = 1
    } else {
      wheelchair = 0
    }
  }
  wheelchair
  
  # Concierge
  if ("Concierge" %in% not_amenities) {
    concierge = 0
  } else {
    if("Concierge" %in% amenities) {
      concierge = 1
    } else {
      concierge = 0
    }
  }
  concierge
  
  # Laundry Service
  if ("Laundry Service" %in% not_amenities) {
    laundry = 0
  } else {
    if("Laundry Service" %in% amenities) {
      laundry = 1
    } else {
      laundry = 0
    }
  }
  laundry
  
  # Gym / Fitness Center
  if ("Fitness Center with Gym / Workout Room" %in% not_amenities) {
    gym = 0
  } else {
    if("Fitness Center with Gym / Workout Room" %in% amenities) {
      gym = 1
    } else {
      gym = 0
    }
  }
  gym
  
  # Free Wifi
  # TO DO: Add in free internet
  if ("Free High Speed Internet (WiFi)" %in% not_amenities) {
    wifi = 0
  } else {
    if("Free High Speed Internet (WiFi)" %in% amenities) {
      wifi = 1
    } else {
      wifi = 0
    }
  }
  wifi
  
  # Multilingual staff
  if ("Multilingual Staff" %in% not_amenities) {
    languages = 0
  } else {
    if("Multilingual Staff" %in% amenities) {
      languages = 1
    } else {
      languages = 0
    }
  }
  languages
  
  # Non-smoking
  if ("Non-Smoking Hotel" %in% not_amenities) {
    smoke = 0
  } else {
    if("Non-Smoking Hotel" %in% amenities) {
      smoke = 1
    } else {
      smoke = 0
    }
  }
  smoke
  
  # Breakfast included
  if ("Breakfast included" %in% not_amenities) {
    breakfast = 0
  } else {
    if("Breakfast included" %in% amenities) {
      breakfast = 1
    } else {
      breakfast = 0
    }
  }
  breakfast
  
  # Airport transportation
  if ("Airport Transportation" %in% not_amenities) {
    air_trans = 0
  } else {
    if("Airport Transportation" %in% amenities) {
      air_trans = 1
    } else {
      air_trans = 0
    }
  }
  air_trans
  
  # Free Parking
  if ("Free Parking" %in% not_amenities) {
    parking = 0
  } else {
    if("Free Parking" %in% amenities) {
      parking = 1
    } else {
      parking = 0
    }
  }
  parking
  
  # Beachfront
  if ("Beachfront" %in% not_amenities) {
    beach = 0
  } else {
    if("Beachfront" %in% amenities) {
      beach = 1
    } else {
      beach = 0
    }
  }
  beach
  
  # Get low and high prices
  # First extract nodes that contain the price range:
  content <- tripadv_hotel %>%
    html_nodes(".sub_content") %>% 
    html_text
  content
  
  # Locate row containing price data
  position <- str_which(content, "(Based on Average Rates for a Standard Room)")
  position
  length(position)
  
  if (length(position) > 0) {
    # Extract the price range
    range <- content[[position[[1]][1]]][1]
    # Split by spaces
    prices <- str_split(range, " ")
    # Isolate low and high prices
    low <- prices[[1]][1]
    high <- prices[[1]][3]
    # Remove $ and commas
    low <- gsub(",", "", low)
    low <- gsub("\\$", "", low)
    high <- gsub(",", "", high)
    high <- gsub("\\$", "", high)
    # Convert to numeric
    low_price <- as.numeric(low)
    high_price <- as.numeric(high)
    low_price
    high_price
  } else {
    low_price = "NA"
    high_price = "NA"
  }
  low_price
  high_price
  
  # Gather this all into a data frame
  hotel_record <- data.frame(Hotel_Name = hotel_name,
                             Street_Address = street_address,
                             City_State_Zip = locality,
                             Guest_Rating = rating,
                             Number_Reviews = num_reviews, 
                             Pool = pool,
                             Bar_Lounge = bar,
                             Business_Center = biz_center,
                             Conference_Facilities = conference,
                             Meeting_Rooms = meeting,
                             Wheelchair_Access = wheelchair,
                             Concierge = concierge,
                             Laundry_Service = laundry,
                             Gym = gym,
                             Free_Wifi = wifi,
                             Multilingual_Staff = languages,
                             Non_Smoking = smoke,
                             Breakfast_Included = breakfast,
                             Airport_Transport = air_trans,
                             Free_Parking = parking, 
                             Beachfront = beach,
                             Low_Price = low_price,
                             High_Price = high_price)
  hotel_record
}

tripadv_hotel <- read_html("https://www.tripadvisor.com/Hotel_Review-g34439-d10587631-Reviews-Urbanica_The_Meridian_Hotel-Miami_Beach_Florida.html")

tripadv_hotel_1 <- read_html("https://www.tripadvisor.com/Hotel_Review-g34439-d87028-Reviews-Eden_Roc_Miami_Beach_Resort-Miami_Beach_Florida.html")

tripadv_hotel_2 <- read_html("https://www.tripadvisor.com/Hotel_Review-g34439-d7606777-Reviews-1_Hotel_South_Beach-Miami_Beach_Florida.html")

get_hotel_record(tripadv_hotel)
View(get_hotel_record(tripadv_hotel))

get_hotel_record(tripadv_hotel_1)
View(get_hotel_record(tripadv_hotel_1))

View(get_hotel_record(tripadv_hotel_2))

# Collect all the URLs from a city page:
tripadvisor_city_url <- read_html("https://www.tripadvisor.com/Hotels-g34179-Delray_Beach_Florida-Hotels.html")

hotel_urls <- tripadvisor_city_url %>%
  html_nodes(".prominent") %>% 
  html_attr('href')
hotel_urls

# Loop through a page of hotels
get_hotels <- function(hotel_urls){
  data = data.frame()
  i = 1
  for(i in 1:length(hotel_urls)) {
    tripadv_hotel <- read_html(paste("https://www.tripadvisor.com",hotel_urls[i], sep = ""))
    hotel_record <- get_hotel_record(tripadv_hotel)
    data <- rbind.fill(data, hotel_record)
    print(i)
  }
  data
}

hotels_df <- get_hotels(hotel_urls)
View(hotels_df)

# Now to loop through all pages for each city
########### FIX THIS!
get_all_hotels <- function(tripadvisor_city_url, X){
  data <- data.frame()
  i = 1
  for(i in 1:X){
    if(i != 1){ # Go to next page but don't skip the first page
      next_URL <- tripadvisor_city_url %>%
        html_nodes(".nav.next") %>%
        html_attr("href")
      tripadvisor_city_url <- jump_to(tripadvisor_city_url, paste("https://www.tripadvisor.com", next_URL, sep = ""))
    }
    hotel_urls <- tripadvisor_city_url %>%
      html_nodes(".prominent") %>%
      html_attr("href")
    hotels_df <- get_hotels(hotel_urls)
    data <- rbind.fill(data, hotels_df)
    print(paste("Page ", i))
  }
  data
}

tripadvisor_city_url <- html_session("https://www.tripadvisor.com/Hotels-g34179-Delray_Beach_Florida-Hotels.html")

get_all_hotels(tripadvisor_city_url, 2)

url <- read_html("https://www.tripadvisor.com/Hotel_Review-g34179-d1060138-Reviews-Berkshire_on_the_Ocean-Delray_Beach_Florida.html")
tripadv_hotel <- read_html("https://www.tripadvisor.com/Hotel_Review-g34179-d1060138-Reviews-Berkshire_on_the_Ocean-Delray_Beach_Florida.html")
get_hotel_record(tripadv_hotel)

# First extract nodes that contain the price range:
content <- url_1 %>%
  html_nodes(".sub_content") %>% 
  html_text
content






