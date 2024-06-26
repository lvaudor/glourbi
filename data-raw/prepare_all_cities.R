library(tidyverse)

#' prepare a tibble with the path to the shapefiles,
#' and the sf objects themselves (pol for polygons)
tib=tibble::tibble(dir=list.files("data-raw/data-gitignored/per_city_raw") %>%
                     stringr::str_subset("study_area_"),
                   file=paste0("data-raw/data-gitignored/per_city_raw/",dir,"/",dir,".shp")) %>%
  mutate(pol=purrr::map(file,sf::st_read))

#' The splash_pol function writes the sf objects (pol) to shapefiles in directory "inst/per_city"
splash_pol=function(pol){
  pol %>%
    mutate(filename=paste0("inst/per_city/",CityCode,".shp")) %>%
    group_by(CityCode,filename) %>%
    tidyr::nest() %>%
    mutate(do=purrr::walk2(.x=data,.y=filename,~sf::st_write(.x,dsn=.y,overwrite=TRUE)))
}

#' Create target directory and run splash_pol to get individual shapefiles for each city
dir.create("inst/per_city")
purrr::map(tib$pol,splash_pol)

#' Get list of cities (identifiers CityCode and name UrbanAggl)
selection1_cities=tib %>%
  select(pol) %>%
  mutate(pol=purrr::map(pol,sf::st_drop_geometry)) %>%
  mutate(pol=purrr::map(pol,~select(.x,CityCode,UrbanAggl=starts_with("Urban")))) %>%
  # in some shapefiles name is "Urban.Aggl" instead of "UrbanAggl"
  tidyr::unnest(cols="pol") %>%
  unique()



## code to prepare `DATASET` dataset goes here
all_cities=read_csv("data-raw/data-gitignored/GHS_all_complete_subset.csv")

all_cities=all_cities %>%
  mutate(Continent=case_when(is.na(Continent)~"AN",
                              TRUE~Continent)) %>%
  group_by(Urban.Aggl) %>%
  mutate(ntot=n()) %>%
  mutate(rank=1:n()) %>%
  mutate(rank=case_when(ntot==1~"",
                        TRUE~as.character(rank))) %>%
  mutate(name=paste0(Urban.Aggl,"-", rank,"-",Country.or)) %>%
  select(-Urban.Aggl,-ntot,-rank) %>%
  ungroup() %>%
  mutate(biom=paste0("b",sprintf("%02d",biom)),
         clco=paste0("c",sprintf("%02d",clco)),
         clim=paste0("c",sprintf("%02d",clim))) %>%
  mutate(biom=as.factor(biom),
         clco=as.factor(clco),
         clim=as.factor(clim)
         ) %>%
  na.omit() %>%
  mutate(selection1=case_when(ID %in% selection1_cities$CityCode~ TRUE,
                           TRUE~ FALSE))

usethis::use_data(all_cities, overwrite = TRUE)


##
meta_all_cities=readr::read_delim("data-raw/data-gitignored/GHS_all_complete_subset_README.txt",
                                  delim = ";",
                                  escape_double = FALSE, trim_ws = TRUE)
usethis::use_data(meta_all_cities, overwrite=TRUE)


