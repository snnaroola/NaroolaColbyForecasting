read_observations = function(scientificname = "Amblyraja radiata",
                             minimum_year = 1970, 
                             ...){
  
  #' Read raw OBIS data and then filter it
  #' 
  #' @param scientificname chr, the name of the species to read
  #' @param minimum_year num, the earliest year of observation to accept or 
  #'   set to NULL to skip
  #' @param ... other arguments passed to `read_obis()`
  #' @return a filtered table of observations
  
  # Happy coding!
  
  # read in the raw data
  x = read_obis(scientificname, ...) |>
    dplyr::mutate(month = factor(month, levels = month.abb))
  
  
  # eventDate can't be NA
  x = x |>
    filter(!is.na(eventDate))
  
  # just keeping human observation and occurrence 
 x = x |>
    dplyr::filter(basisOfRecord %in% c("HumanObservation", "Occurrence"))
  
  # individualCount can't be NA - chose to comment out ultimately because
  # forecasting habitat suitability not abundance or population so just need to 
  # know presence versus background so would be throwing away data unnecessarily
  # basically everything after 2013)
  
  # x = x |>
  #  filter(!is.na(individualCount))
  
  
  # if the user provided a non-NULL filter by year
  if (!is.null(minimum_year)){
    x = x |>
      filter(year >= minimum_year)
  }
  
  
  # filter out observations not in mask (filter out land obs)
  db = brickman_database() |>
    filter(scenario == "STATIC", var == "mask")
  
  mask = read_brickman(db)
  
  hitOrMiss = extract_brickman(mask, x)
  
  x = x |>
    filter(!is.na(hitOrMiss$value))
  # doesnt change anything because i didnt have land obs
  
  return(x)
}

# ran this 

#dim_end = read_observations(scientificname = "Amblyraja radiata",
#                            minimum_year = 1970)
#dim_end
#dim_start

# to get 23617 features and 7 fields which is the same result from running all 
# the filters on my species in the markdown file (not including individual count)
# dim_start was 8 fields but after looking it up that is because dim counts
# geometry and printing does not
