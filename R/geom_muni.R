geom_muni <- stat_muni
geom_muni_label <- function(...){stat_muni(geom = "text",...)}
stamp_muni <- function(...){
  stat_muni(stamp = T, 
              data = mtcars,
              aes(fill = NULL, color = NULL, label = NULL, 
                  fips = NULL, muni_name = NULL), 
              ...)}
stamp_muni_label <- function(...){
  stat_muni(stamp = T, 
              geom = "text", 
              data = mtcars, 
              aes(fill = NULL, color = NULL,
                  fips = NULL, muni_name = NULL), 
              ...)}
