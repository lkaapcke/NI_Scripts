# This is a function to retrieve hotel data from a tripadvisor hotel description page.

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
  
  # Test for each amenity
  # Pool
  if ("Pool" %in% amenities) {
    pool = 1
  } else {
    pool = 0
  }
  pool
  
  # Bar/Lounge
  if ("Bar/Lounge" %in% amenities) {
    bar = 1
  } else {
    bar = 0
  }
  bar
  
  # Business Center
  if ("Business Center with Internet Access" %in% amenities) {
    biz_center = 1
  } else {
    biz_center = 0
  }
  biz_center
  
  # Conference facilities
  if ("Conference Facilities" %in% amenities) {
    conference = 1
  } else {
    conference = 0
  }
  conference
  
  # Meeting Rooms
  if ("Meeting Rooms" %in% amenities) {
    meeting = 1
  } else {
    meeting = 0
  }
  meeting
  
  # Wheelchair Access
  if ("Wheelchair access" %in% amenities) {
    wheelchair = 1
  } else {
    wheelchair = 0
  }
  wheelchair
  
  # Concierge
  if ("Concierge" %in% amenities) {
    concierge = 1
  } else {
    concierge = 0
  }
  concierge
  
  # Laundry Service
  if ("Laundry Service" %in% amenities) {
    laundry = 1
  } else {
    laundry = 0
  }
  laundry
  
  # Gym / Fitness Center
  if ("Fitness Center with Gym / Workout Room" %in% amenities) {
    gym = 1
  } else {
    gym = 0
  }
  gym
  
  # Free Wifi
  # TO DO: Add in free internet
  if ("Free High Speed Internet (WiFi)" %in% amenities) {
    wifi = 1
  } else {
    wifi = 0
  }
  wifi
  
  # Multilingual staff
  if ("Multilingual Staff" %in% amenities) {
    languages = 1
  } else {
    languages = 0
  }
  languages
  
  # Non-smoking
  
  # Breakfast included
  
  # Airport transportation
  
  # Free Parking
  
  # Beachfront

  hotel_record <- data.frame(Hotel_Name = hotel_name,
                             Street_Address = street_address,
                             City_State_Zip = locality,
                             Guest_Rating = rating,
                             Number_Reviews = num_reviews)
  hotel_record
}

tripadv_hotel <- read_html("https://www.tripadvisor.com/Hotel_Review-g34439-d10587631-Reviews-Urbanica_The_Meridian_Hotel-Miami_Beach_Florida.html")

tripadv_hotel_1 <- read_html("https://www.tripadvisor.com/Hotel_Review-g34439-d87028-Reviews-Eden_Roc_Miami_Beach_Resort-Miami_Beach_Florida.html")

get_hotel_record(tripadv_hotel)
View(get_hotel_record(tripadv_hotel))

get_hotel_record(tripadv_hotel_1)
View(get_hotel_record(tripadv_hotel_1))
