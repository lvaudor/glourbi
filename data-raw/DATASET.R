library(tidyverse)
## code to prepare `DATASET` dataset goes here
all_cities=read_csv("data-raw/GHS_all_complete_subset.csv")
all_cities=all_cities %>%
  group_by(Urban.Aggl) %>%
  mutate(ntot=n()) %>%
  mutate(rank=1:n()) %>%
  mutate(rank=case_when(ntot==1~"",
                        TRUE~as.character(rank))) %>%
  mutate(name=paste0(Urban.Aggl,rank)) %>%
  select(-Urban.Aggl,-ntot,-rank) %>%
  ungroup() %>%
  mutate(biom=paste0("b",biom),
         clco=paste0("c",clco))

usethis::use_data(all_cities, overwrite = TRUE)


