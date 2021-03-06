% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{mapIntersectGCAMBasinCountrydf}
\alias{mapIntersectGCAMBasinCountrydf}
\title{Intersection of GCAM Basins and countries.}
\format{
R tibble
}
\source{
JGCRI
}
\usage{
mapIntersectGCAMBasinCountrydf
}
\description{
Intersection of GCAM Basins and countries.
}
\examples{
\dontrun{
 library(sp); library(rmapdata); library(ggplot2)
 ggplot() +
 geom_polygon(data = mapIntersectGCAMBasinCountrydf, aes(x = long, y = lat, group = group),
             colour = "black", fill = NA)
 head(mapIntersectGCAMBasinCountrydf)
}
}
\keyword{datasets}
