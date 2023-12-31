% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_color.R
\name{get_color}
\alias{get_color}
\title{Returns the color associated with a certain value of a categorical variable}
\usage{
get_color(dataset = all_cities, varname, value)
}
\arguments{
\item{dataset}{a dataset, defaults to all_cities}

\item{varname}{name of the variable considered, as string}

\item{value}{name of the value, as string}
}
\value{
a hex color value
}
\description{
Returns the color associated with a certain value of a categorical variable
}
\examples{
get_color(all_cities,"biom","b08")
all_cities_clust=run_hclust(all_cities,15)
get_color(all_cities_clust,"cluster","cl12")
}
