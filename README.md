
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ggsomewhere

<!-- badges: start -->

<!-- badges: end -->

The goal of ggsomewhere (and it’s github repository) is to provide tools
for building spatial ggplot2 extensions.

The approach makes use of ggplot2’s sf plotting capabilities, the
sf2stat package to prepare reference data for use inside a stat\_\* or
geom\_\* layer, and the readme2pkg package functions for managing
functions from a readme and working with template functions included in
the readme.

## Fully worked example…

How you’d use sf2stat to build functionality with scope, region type,
and location name. When using the code templates for this north carolina
county example, we’ll be replacing ‘scope’, ‘region’, and ‘locations’ as
follows

  - ‘scope’ -\> ‘brasil’
  - ‘region’ -\> ‘county’
  - ‘locations’ -\> a vector of region names

Let’s see how we might recreate the functionality in the ggnorthcarolina
package using some templates in this readme.

In the example, the scope of the package is ‘northcarolina’. The region
of interest is ‘county’, and the location names that we are using are
the county names.

## 

``` r
devtools::create(".")
```

## Step 00. prep reference data

### Create

``` r
usethis::use_data_raw()
```

## Preparation

The reference data should have just the id columns and the geometry.
Then it should be named similar to this:

geo\_reference\_brasil\_

Where ‘northcarolina’ is is the character string that will replace
‘scope’ when using the code templates, and ‘county’ is the character
string that will replace region in the

``` r
br_state <- geobr::read_state(simplified = T)
#> Loading required namespace: sf
#> Using year 2010
#>   |                                                                              |                                                                      |   0%  |                                                                              |===                                                                   |   4%  |                                                                              |=====                                                                 |   7%  |                                                                              |========                                                              |  11%  |                                                                              |==========                                                            |  15%  |                                                                              |=============                                                         |  19%  |                                                                              |================                                                      |  22%  |                                                                              |==================                                                    |  26%  |                                                                              |=====================                                                 |  30%  |                                                                              |=======================                                               |  33%  |                                                                              |==========================                                            |  37%  |                                                                              |=============================                                         |  41%  |                                                                              |===============================                                       |  44%  |                                                                              |==================================                                    |  48%  |                                                                              |====================================                                  |  52%  |                                                                              |=======================================                               |  56%  |                                                                              |=========================================                             |  59%  |                                                                              |============================================                          |  63%  |                                                                              |===============================================                       |  67%  |                                                                              |=================================================                     |  70%  |                                                                              |====================================================                  |  74%  |                                                                              |======================================================                |  78%  |                                                                              |=========================================================             |  81%  |                                                                              |============================================================          |  85%  |                                                                              |==============================================================        |  89%  |                                                                              |=================================================================     |  93%  |                                                                              |===================================================================   |  96%  |                                                                              |======================================================================| 100%
br_muni <- geobr::read_municipality()
#> Using year 2010
#>   |                                                                              |                                                                      |   0%  |                                                                              |===                                                                   |   4%  |                                                                              |=====                                                                 |   7%  |                                                                              |========                                                              |  11%  |                                                                              |==========                                                            |  15%  |                                                                              |=============                                                         |  19%  |                                                                              |================                                                      |  22%  |                                                                              |==================                                                    |  26%  |                                                                              |=====================                                                 |  30%  |                                                                              |=======================                                               |  33%  |                                                                              |==========================                                            |  37%  |                                                                              |=============================                                         |  41%  |                                                                              |===============================                                       |  44%  |                                                                              |==================================                                    |  48%  |                                                                              |====================================                                  |  52%  |                                                                              |=======================================                               |  56%  |                                                                              |=========================================                             |  59%  |                                                                              |============================================                          |  63%  |                                                                              |===============================================                       |  67%  |                                                                              |=================================================                     |  70%  |                                                                              |====================================================                  |  74%  |                                                                              |======================================================                |  78%  |                                                                              |=========================================================             |  81%  |                                                                              |============================================================          |  85%  |                                                                              |==============================================================        |  89%  |                                                                              |=================================================================     |  93%  |                                                                              |===================================================================   |  96%  |                                                                              |======================================================================| 100%


geo_reference_brasil_state <- br_state |>
  dplyr::select(state_name = name_state, state_code = code_state, state_abbrev = abbrev_state, geometry = geom) |>
  sf2stat:::sf_df_prep_for_stat(id_col_name = "state_name")
#> Warning in st_point_on_surface.sfc(sf::st_zm(dplyr::pull(sf_df, geometry))):
#> st_point_on_surface may not give correct results for longitude/latitude data
#> Warning: The `x` argument of `as_tibble.matrix()` must have unique column names if
#> `.name_repair` is omitted as of tibble 2.0.0.
#> ℹ Using compatibility `.name_repair`.
#> ℹ The deprecated feature was likely used in the sf2stat package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.

geo_reference_brasil_muni <- br_muni |>
  dplyr::select(muni_name = name_muni, muni_code = code_muni, state_abbrev = abbrev_state, geometry = geom) |>
  sf2stat:::sf_df_prep_for_stat(id_col_name = "muni_name")
#> Warning in st_point_on_surface.sfc(sf::st_zm(dplyr::pull(sf_df, geometry))):
#> st_point_on_surface may not give correct results for longitude/latitude data

usethis::use_data(geo_reference_brasil_state, overwrite = T)
#> ✔ Setting active project to '/Users/evangelinereynolds/Google
#> Drive/r_packages/ggbrasil2'
#> ✔ Saving 'geo_reference_brasil_state' to 'data/geo_reference_brasil_state.rda'
#> • Document your data (see 'https://r-pkgs.org/data.html')
usethis::use_data(geo_reference_brasil_muni, overwrite = T)
#> ✔ Saving 'geo_reference_brasil_muni' to 'data/geo_reference_brasil_muni.rda'
#> • Document your data (see 'https://r-pkgs.org/data.html')
```

``` r
readme2pkg::chunk_to_dir("geo_reference_brasil_state", 
                         dir = "data-raw/")
```

## Use template to create `stat_county()` functionality

``` r
readme2pkg::chunk_variants_to_dir(chunk_name = "stat_region_template",
                                  file_name = "stat_state.R",
                                  replace1 = "scope",
                                  replacements1 = "brasil",
                                  replace2 = "region",
                                  replacements2 = "state")

readme2pkg::chunk_variants_to_dir(chunk_name = "stat_region_template",
                                  file_name = "stat_muni.R",
                                  replace1 = "scope",
                                  replacements1 = "brasil",
                                  replace2 = "region",
                                  replacements2 = "muni")
```

``` r
compute_panel_scope_region <- function(data, 
                                       scales, 
                                       keep_id = NULL, 
                                       drop_id = NULL, 
                                       stamp = FALSE){
  
  if(!stamp){data <- dplyr::inner_join(data, geo_reference_scope_region)}
  if( stamp){data <- geo_reference_scope_region }
  
  if(!is.null(keep_id)){ data <- dplyr::filter(data, id_col %in% keep_id) }
  if(!is.null(drop_id)){ data <- dplyr::filter(data, !(id_col %in% drop_id)) }
  
  data
  
}

# step 2
StatSfscoperegion <- ggplot2::ggproto(`_class` = "StatSfscoperegion",
                                `_inherit` = ggplot2::Stat,
                                # required_aes = c("fips|county_name"),
                                compute_panel = compute_panel_scope_region,
                               default_aes = ggplot2::aes(label = after_stat(id_col)))


stat_region <- function(
      mapping = NULL,
      data = NULL,
      geom = ggplot2::GeomSf,
      position = "identity",
      na.rm = FALSE,
      show.legend = NA,
      inherit.aes = TRUE,
      crs = "NAD27", # "NAD27", 5070, "WGS84", "NAD83", 4326 , 3857
      ...) {

  c(ggplot2::layer_sf(
              stat = StatSfscoperegion,  # proto object from step 2
              geom = geom,  # inherit other behavior
              data = data,
              mapping = mapping,
              position = position,
              show.legend = show.legend,
              inherit.aes = inherit.aes,
              params = rlang::list2(na.rm = na.rm, ...)
              ),
              
              coord_sf(crs = crs,
                       default_crs = sf::st_crs(crs),
                       datum = crs,
                       default = TRUE)
     )
  }
```

### test it out `stat_county()`

``` r
source("./R/stat_state.R")
source("./R/stat_muni.R")



library(ggplot2)


br_state |>
  sf::st_drop_geometry() |>
  ggplot() +
  aes(state_name = name_state) +
  stat_state(alpha = .4) + 
  aes(fill = name_region)
#> Joining with `by = join_by(state_name)`
```

![](README_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

``` r

br_muni |>
  sf::st_drop_geometry() |>
  ggplot() +
  aes(muni_code = code_muni) +
  stat_muni(alpha = .4, linewidth = .02) + 
  aes(fill = abbrev_state)
#> Joining with `by = join_by(muni_code)`
```

![](README_files/figure-gfm/unnamed-chunk-6-2.png)<!-- -->

## Use template to create useful derivitive functions

``` r
readme2pkg::chunk_variants_to_dir(chunk_name = "geom_region_template",
                                  file_name = "geom_state.R",
                                  replace1 = "region",
                                  replacements1 = "state")


readme2pkg::chunk_variants_to_dir(chunk_name = "geom_region_template",
                                  file_name = "geom_muni.R",
                                  replace1 = "region",
                                  replacements1 = "muni")
```

``` r
geom_region <- stat_region
geom_region_label <- function(...){stat_region(geom = "text",...)}
stamp_region <- function(...){
  stat_region(stamp = T, 
              data = mtcars,
              aes(fill = NULL, color = NULL, label = NULL, 
                  fips = NULL, region_name = NULL), 
              ...)}
stamp_region_label <- function(...){
  stat_region(stamp = T, 
              geom = "text", 
              data = mtcars, 
              aes(fill = NULL, color = NULL,
                  fips = NULL, region_name = NULL), 
              ...)}
```

### try those out

``` r
source("./R/geom_state.R")
source("./R/geom_muni.R")


br_state |>
  sf::st_drop_geometry() |>
  ggplot() +
  aes(state_name = name_state) +
  geom_state() + 
  geom_state_label(check_overlap = T,
                    color = "grey85") +
  aes(fill = name_region) 
#> Joining with `by = join_by(state_name)`
#> Joining with `by = join_by(state_name)`
```

![](README_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

``` r

br_muni |>
  sf::st_drop_geometry() |>
  ggplot() +
  aes(muni_code = code_muni) + 
  geom_muni(linewidth = .02) + 
  geom_muni_label(check_overlap = T,
                    color = "grey85", size = 3) +
  aes(fill = abbrev_state)
#> Joining with `by = join_by(muni_code)`
#> Joining with `by = join_by(muni_code)`
```

![](README_files/figure-gfm/unnamed-chunk-8-2.png)<!-- -->

``` r

ggplot() + 
  stamp_state()
```

![](README_files/figure-gfm/unnamed-chunk-8-3.png)<!-- -->

``` r

last_plot() + 
  stamp_state_label(check_overlap = T)
```

![](README_files/figure-gfm/unnamed-chunk-8-4.png)<!-- -->

``` r

last_plot() + 
  stamp_state(keep_id = "Amapá", fill = "darkred") +
  stamp_state_label(keep_id = "Amapá", color = "oldlace")
```

![](README_files/figure-gfm/unnamed-chunk-8-5.png)<!-- -->

``` r

ggplot() + 
  stamp_muni(linewidth = .02)
```

![](README_files/figure-gfm/unnamed-chunk-8-6.png)<!-- -->

## Use template to write convenience functions for each region

``` r
locations <- geo_reference_brasil_state$state_name
locations_snake <- tolower(locations) |> 
  stringr::str_replace_all(" ", "_")

readme2pkg::chunk_variants_to_dir(chunk_name = "stamp_region_location", 
                                  file_name = "stamp_state_location.R",
                                  replace1 = "region",
                                  replacements1 = rep("state", length(locations)),
                              replace2 = "location",
                              replacements2 = locations_snake,
                              replace3 = "Location", 
                              replacements3 = locations)


locations <- geo_reference_brasil_muni$muni_name
locations_snake <- tolower(locations) |> 
  stringr::str_replace_all(" ", "_") |>
  stringr::str_replace_all("'", "_") |>
  stringr::str_replace_all("-", "_")

readme2pkg::chunk_variants_to_dir(chunk_name = "stamp_region_location", 
                                  file_name = "stamp_muni_location.R",
                                  replace1 = "region",
                                  replacements1 = rep("muni", length(locations)),
                              replace2 = "location",
                              replacements2 = locations_snake,
                              replace3 = "Location", 
                              replacements3 = locations)
```

``` r
#' Title
#'
#' @param ... 
#'
#' @return
#' @export
#'
#' @examples
stamp_region_location <- function(...){stamp_region(keep_id = "Location", ...)}

#' Title
#'
#' @param ... 
#'
#' @return
#' @export
#'
#' @examples
stamp_region_label_location <- function(...){stamp_region_label(keep_id = "Location", ...)}
```

### Try it out

``` r
source("./R/stamp_state_location.R")
source("./R/stamp_muni_location.R")


#library(ggbrasil2)

ggplot() +
  aes(state_name = name_state) + 
  stamp_state() + 
  stamp_state_espirito_santo(fill = "green") +
  stamp_state_label_goiás() + 
  stamp_state_label_maranhão() + 
  stamp_state_distrito_federal(fill = "red")
```

![](README_files/figure-gfm/last_test-1.png)<!-- -->

``` r

ggplot() +
  stamp_state() +
  stamp_muni_alvarães(fill = "magenta") +
  stamp_muni_água_azul_do_norte(fill = "blue")
```

![](README_files/figure-gfm/last_test-2.png)<!-- -->
