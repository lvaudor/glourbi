#' Get sf data
#' @param name the name of the table (with geometry)
#' @param thisCityCode, the city code
#' @param conn the connection
#' @return the contents of table with name for rows about citycode
#' @export
get_city_sf=function(name, thisCityCode, conn){
  conn=glourbi::connect_to_glourb()
  sql <- "SELECT * FROM ?name WHERE citycode LIKE ?thisCityCode"
  query <- DBI::sqlInterpolate(conn, sql,
                               thisCityCode = thisCityCode,
                               name=name)
  result <- sf::st_read(dsn = conn, query = query)
  return(result)
}

#' Get tibble data
#' @param name the name of the table (no geometry)
#' @param thisCityCode, the city code
#' @param conn the connection
#' @return the contents of table with name for rows about citycode
#' @export
get_city_tib=function(name, thisCityCode, conn){
  conn=glourbi::connect_to_glourb()
  sql <- "SELECT * FROM ?name WHERE citycode LIKE ?thisCityCode"
  query <- DBI::sqlInterpolate(conn, sql,
                          thisCityCode = thisCityCode,
                          name=name)
  result <- DBI::dbGetQuery(conn=conn, statement = query)
  return(result)
}
