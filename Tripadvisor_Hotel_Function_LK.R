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
  
  num_reviews <- as.numeric(gsub(",", "", reviews[[1]][1]))
  #num_reviews


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

get_hotel_record(tripadv_hotel_1)
