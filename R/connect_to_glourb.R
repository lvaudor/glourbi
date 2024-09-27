#' Connects to the sandbox database. The necessary parameters are in the R user environment (usethis::edit_r_environ())
#' @export
connect_to_glourb <- function(){
  conn <- DBI::dbConnect(RPostgres::Postgres(),
                         host = Sys.getenv("GLOURB_HOST"),
                         port = Sys.getenv("GLOURB_PORT"),
                         dbname = Sys.getenv("GLOURB_NAME"),
                         user      = Sys.getenv("GLOURB_USER_APP"),
                         password  = Sys.getenv("GLOURB_PASS_APP"))
  return(conn)
}


#' Connects to the sandbox database. The necessary parameters are in the R user environment (usethis::edit_r_environ())
#' @export
connect_to_sandbox <- function(){
  conn <- DBI::dbConnect(RPostgres::Postgres(),
                         host = Sys.getenv("SANDBOX_HOST"),
                         port = Sys.getenv("SANDBOX_PORT"),
                         dbname = Sys.getenv("SANDBOX_NAME"),
                         user      = Sys.getenv("SANDBOX_USER_APP"),
                         password  = Sys.getenv("SANDBOX_PASS_APP"))
  return(conn)
}
