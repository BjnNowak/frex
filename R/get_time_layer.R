#' Add time series layers
#'
#'Add time series data layer, based on the spatial grid of the map obtained by the get_map() function
#'
#' @param layer type of data to be added ("temperature" for monthly mean temperature in °C or "rainfall" for sum of monthly rainfall in mm). Climatic data layers (temperature and rainfall) are available from 2000 to 2020. 
#' @param from starting year (from 2000 to 2020) 
#' @param to ending year (may be the same as starting year to extract only one year of data)
#'
#' @return a tibble with the hexagon number ("hex_id" column) and the selected features values
#' 
#' @import sf
#' @import tidyverse 
#' 
#' @references 
#' Climate data from [ERA5](https://developers.google.com/earth-engine/datasets/catalog/ECMWF_ERA5_MONTHLY)
#'
#' @examples
#'# Get mean temperature from 2000 to 2020 and filter for May only
#'library(sf)
#'library(tidyverse)
#'
#'data<-get_time_layer("temperature",from=2000, to=2020)%>%
#'   filter(month==5)
#' 
#' @export
get_time_layer<-function(
    layer, # Two choices: "rainfall" (for total temperature per month, in mm) or "temperature" (for mean temperature per month, in °C)
    from,  # Starting year of the selection (from 2000 to 2020)
    to     # Ending year of the selection (it may be the same as the starting year to extract only one year)
){
  
  # Make tibble with URLs
  tb<-tibble(
    name=c(
      rep('rainfall',21),
      rep('temperature',21)
    ),
    year=rep(seq(2000,2020,1),2),
    url=c(
      # Rainfall
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/rainfall/rainfall_2000.csv', #2000
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/rainfall/rainfall_2001.csv', #2001
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/rainfall/rainfall_2002.csv', #2002
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/rainfall/rainfall_2003.csv', #2003
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/rainfall/rainfall_2004.csv', #2004
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/rainfall/rainfall_2005.csv', #2005
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/rainfall/rainfall_2006.csv', #2006
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/rainfall/rainfall_2007.csv', #2007
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/rainfall/rainfall_2008.csv', #2008
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/rainfall/rainfall_2009.csv', #2009
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/rainfall/rainfall_2010.csv', #2010
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/rainfall/rainfall_2011.csv', #2011
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/rainfall/rainfall_2012.csv', #2012
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/rainfall/rainfall_2013.csv', #2013
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/rainfall/rainfall_2014.csv', #2014
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/rainfall/rainfall_2015.csv', #2015
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/rainfall/rainfall_2016.csv', #2016
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/rainfall/rainfall_2017.csv', #2017
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/rainfall/rainfall_2018.csv', #2018
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/rainfall/rainfall_2019.csv', #2019
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/rainfall/rainfall_2020.csv', #2020
      # Mean temperature
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/temperature/temp_2000.csv', #2000
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/temperature/temp_2001.csv', #2001
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/temperature/temp_2002.csv', #2002
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/temperature/temp_2003.csv', #2003
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/temperature/temp_2004.csv', #2004
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/temperature/temp_2005.csv', #2005
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/temperature/temp_2006.csv', #2006
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/temperature/temp_2007.csv', #2007
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/temperature/temp_2008.csv', #2008
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/temperature/temp_2009.csv', #2009
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/temperature/temp_2010.csv', #2010
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/temperature/temp_2011.csv', #2011
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/temperature/temp_2012.csv', #2012
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/temperature/temp_2013.csv', #2013
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/temperature/temp_2014.csv', #2014
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/temperature/temp_2015.csv', #2015
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/temperature/temp_2016.csv', #2016
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/temperature/temp_2017.csv', #2017
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/temperature/temp_2018.csv', #2018
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/temperature/temp_2019.csv', #2019
      'https://raw.githubusercontent.com/BjnNowak/frex_db/main/data/climate/temperature/temp_2020.csv' #2020
    )
  )%>%
    filter(name==layer)%>%
    filter(year>=from&year<=to)
  
  ext<-read_csv(tb$url[1],show_col_types=FALSE)
  
  if (dim(tb)[1]>1) {
    for (i in 2:dim(tb)[1]){
      ext<-ext%>%
        bind_rows(read_csv(tb$url[i],show_col_types=FALSE))
    }
  } else {
    ext<-ext
  }
  
  return(ext)
}