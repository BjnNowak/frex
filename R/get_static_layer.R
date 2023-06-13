#' Add static data layers 
#'
#'Add static data layer (not updated from year to year), based on the spatial grid of the map obtained by the get_map() function
#'
#' @param layer type of data to be added ("soil" for soil feature, "crops" for main crops distribution, "herds" for farm animal density (aggregated from departmental scale), "herds_municipality" for farm animal density (aggregated from municipality scale), "human" for human population density)
#'
#' @return a tibble with the hexagon number ("hex_id" column) and the selected features values
#' @import sf
#' @import tidyverse
#' 
#' @references 
#' - Soil features from [SoilGrids](https://soilgrids.org/)
#' - Crop distribution from the Land-Parcel Identification System ([Registre Parcellaire Graphique](https://www.data.gouv.fr/fr/datasets/registre-parcellaire-graphique-rpg-contours-des-parcelles-et-ilots-culturaux-et-leur-groupe-de-cultures-majoritaire/) in France) of the European Common Agricultural Policy
#' - Organic crop distribution from [Agence Bio](https://www.data.gouv.fr/fr/datasets/parcelles-en-agriculture-biologique-ab-declarees-a-la-pac/)
#' - Herd density from [Agreste](https://agreste.agriculture.gouv.fr/agreste-web/)
#' - Human population density from [Global Human Settlement Layer](https://ghsl.jrc.ec.europa.eu/download.php?ds=pop)
#'
#' @examples
#'# Get soil features and plot clay content
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
      'organic', #2
      'herds', #4
      'herds_municipality', #5
      'human' #6
    ),
    url=c(
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/soil/soil_properties.csv', #1
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/crop/crop_distribution.csv', #2
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/crop/organic_crop_distribution.csv', #3
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/herds/herds_density.csv', #4
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/herds/herds_density_municipality.csv', #5
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/human/human_pop_density.csv' #6
    )
  )%>%
    filter(name==layer)
  
  ext<-read_csv(tb$url)
  
  return(ext)
}