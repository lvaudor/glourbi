% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fun_palette.R
\name{fun_palette}
\alias{fun_palette}
\title{Build a palette function}
\usage{
fun_palette(dataset = all_cities, varname)
}
\arguments{
\item{dataset}{a dataset, defaults to all_cities}

\item{varname}{a string corresponding to one of the variables in all_cities.}
}
\value{
a function
}
\description{
Build a palette function
}
\examples{
fun_palette(all_cities,"X2018")
fun_palette(all_cities,"clim")
}
