library(tidyverse)
study_areas=sf::st_read("data-raw/study_areas_temp/study_areas_20230713_buffer.shp")


## code to prepare `DATASET` dataset goes here
all_cities=read_csv("data-raw/GHS_all_complete_subset.csv")
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
  mutate(selectA=case_when(City.Code %in% study_areas$City.Code~ TRUE,
                           TRUE~ FALSE))

usethis::use_data(all_cities, overwrite = TRUE)


##
meta_all_cities=readr::read_delim("data-raw/GHS_all_complete_subset_README.txt",
                                  delim = ";",
                                  escape_double = FALSE, trim_ws = TRUE)
usethis::use_data(meta_all_cities, overwrite=TRUE)


