#'Load 
#' 
#'Function to add the gridded hexagonal map of metropolitan France. 
#'This function has no argument
#'
#' @return gridded hexagonal map of metropolitan France
#' @import sf
#'
#' @examples
#' # Load map
#' get_map()%>%
#' ggplot()+
#' geom_sf()
#' @export
get_map<-function(){
  hex<-read_sf('https://github.com/BjnNowak/frex_db/raw/main/map/hex_grid.gpkg')
  return(hex)
}