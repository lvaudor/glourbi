#' Returns city name associated to city code
#' @param citycode the citycode
#' @return cityname
#' @export
#' @examples
#' to_cityname("916904_22567")
to_cityname=function(citycode){
  res=glourbi::all_cities %>%
    dplyr::filter(ID==citycode) %>%
    dplyr::pull(Urban.Aggl)
  return(res)
}

#' Returns city code associated to city name
#' @param cityname the cityname
#' @return citycode
#' @export
#' @examples
#' to_citycode("Denver-Aurora")
to_citycode=function(cityname){
  res=glourbi::all_cities %>%
    dplyr::filter(Urban.Aggl==cityname) %>%
    dplyr::pull(ID)
  return(res)
}
