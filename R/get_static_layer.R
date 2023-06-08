#' Add static data layers 
#'
#'Add static data layer (not updated from year to year), based on the spatial grid of the map obtained by the get_map() function
#'
#' @param layer type of data to be added ("soil" for soil feature, "crops" for main crops distribution, "herds" for farm animal density)
#'
#' @return a tibble with the hexagon number ("hex_id" column) and the selected features values
#' @import sf
#' @import tidyverse
#' 
#' @examples
#'# Add soil features to grid then plot clay content
#'library(sf)
#'library(tidyverse)
#'
#'get_map()%>%
#'   left_join(get_static_layer("soil"))%>%
#'   ggplot()+
#'   geom_sf(aes(fill=clay_0to30cm_percent)) 
#' 
#' @export
get_static_layer<-function(layer){
  tb<-tibble(
    name=c(
      'soil', #1
      'crops', #2
      'herds' #3
    ),
    url=c(
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/soil/soil_properties.csv', #1
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/crop/crop_distribution.csv', #2
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/herds/herds_density.csv' #3
    )
  )%>%
    filter(name==layer)
  
  ext<-read_csv(tb$url)
  
  return(ext)
}