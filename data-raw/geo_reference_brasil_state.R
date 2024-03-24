br_state <- geobr::read_state(simplified = T)
br_muni <- geobr::read_municipality()


geo_reference_brasil_state <- br_state |>
  dplyr::select(state_name = name_state, state_code = code_state, state_abbrev = abbrev_state, geometry = geom) |>
  sf2stat:::sf_df_prep_for_stat(id_col_name = "state_name")

geo_reference_brasil_muni <- br_muni |>
  dplyr::select(muni_name = name_muni, muni_code = code_muni, state_abbrev = abbrev_state, geometry = geom) |>
  sf2stat:::sf_df_prep_for_stat(id_col_name = "muni_name")

usethis::use_data(geo_reference_brasil_state, overwrite = T)
usethis::use_data(geo_reference_brasil_muni, overwrite = T)

