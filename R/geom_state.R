geom_state <- stat_state
geom_state_label <- function(...){stat_state(geom = "text",...)}
stamp_state <- function(...){
  stat_state(stamp = T, 
              data = mtcars,
              aes(fill = NULL, color = NULL, label = NULL, 
                  fips = NULL, state_name = NULL), 
              ...)}
stamp_state_label <- function(...){
  stat_state(stamp = T, 
              geom = "text", 
              data = mtcars, 
              aes(fill = NULL, color = NULL,
                  fips = NULL, state_name = NULL), 
              ...)}
