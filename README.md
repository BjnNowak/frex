{frex} stands for “FRench hEXagons”.

The goal of this package is to provide several layers of information for
metropolitan France, particularly useful for analyzing agricultural
systems.

The basis of this package is a gridded map of France in hexagons of
about 450 km2. For each hexagon, different information can be added
using the package function, such as the surface area occupied by
different types of crop, the nature of the soil or climatic data.

The data is not included in the package itself, but is called up via
URL. It therefore requires an Internet connection to operate.

Package data can be used to illustrate the diversity of French farming
systems. They can also be used to enrich other datasets (e.g. to add
pedoclimatic characteristics to studied agricultural plots), as we have
done in this
[article](https://link.springer.com/article/10.1007/s13593-022-00770-y).

# 1. Package installation

The package may be downloaded from GitHub. It may also be downloaded
directly from R with the following command:

    # Installation directly with R (to use only once):
    # devtools::install_github("BjnNowak/frex")

    # Once installed, you may load it into your R session
    library(frex)

    # Two other packages will be useful to process the data: {tidyverse} and {sf}
    library(tidyverse)
    library(sf)

# 2. Static data layers

The package is based on a hexagonal grid of metropolitan france, to
which data layers can be added. This grid may be loaded as follows,
using the **get\_map()** function:

    hex<-get_map() # No argument

    # Plot hexagonal grid
    ggplot(hex)+
      geom_sf()

![](README_files/figure-markdown_strict/unnamed-chunk-2-1.png)

This base map can be enhanced by adding several layers of data.

Static data layer (not updated from year to year) may be added with the
**get\_static\_layer()** function.

Different type of data may be added this way (“soil” for soil feature,
“crops” for main crops distribution, “herds” for farm animal density).
The distribution of crops and animals can vary over time, but an initial
analysis showed that these distributions were very stable from one year
to the next. As a first approximation, they were therefore considered as
“stable” layers.

Below an example to get the distribution of sunflower crops in France.

    hex<-get_map()%>%
      # Join static layer with the hexagonal grid
      left_join(get_static_layer(layer="crops"))
    #> Rows: 1542 Columns: 10
    #> ── Column specification ────────────────────────────────────────────────────────
    #> Delimiter: ","
    #> dbl (10): hex_id, soft_wheat_area_km2, hard_wheat_area_km2, corn_grain_area_...
    #> 
    #> ℹ Use `spec()` to retrieve the full column specification for this data.
    #> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
    #> Joining with `by = join_by(hex_id)`

    ggplot(hex)+
      geom_sf(
        aes(fill=sunflower_area_km2),
        color="grey90"
      )+
      scale_fill_gradient(
        low="#fff95b",high="#ff930f",
        na.value = "grey95")+
      theme_void()

![](README_files/figure-markdown_strict/unnamed-chunk-3-1.png)

    hex<-get_map()%>%
      # Join static layer with the hexagonal grid
      left_join(get_static_layer(layer="crops"))
    #> Rows: 1542 Columns: 10
    #> ── Column specification ────────────────────────────────────────────────────────
    #> Delimiter: ","
    #> dbl (10): hex_id, soft_wheat_area_km2, hard_wheat_area_km2, corn_grain_area_...
    #> 
    #> ℹ Use `spec()` to retrieve the full column specification for this data.
    #> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
    #> Joining with `by = join_by(hex_id)`

    ggplot(hex)+
      geom_sf(aes(fill=sunflower_area_km2))+
      theme_void()

![](README_files/figure-markdown_strict/unnamed-chunk-4-1.png)
