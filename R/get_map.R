#'Load base gridded hexagonal map for metropolitan France
#' 
#'Function to add the gridded hexagonal map of metropolitan France. 
#'This function has no argument
#'
#' @return a sf object with gridded hexagonal map for metropolitan France
#' @import sf
#' @import tidyverse
#'
#' @examples
#' # Plot the map
#'library(sf)
#'library(tidyverse)
#'
#'get_map()%>%
#'   ggplot()+
#'   geom_sf()
#' @export
get_map<-function(){
  hex<-read_sf('https://github.com/BjnNowak/frex_db/raw/main/map/hex_grid.gpkg')
  return(hex)
}