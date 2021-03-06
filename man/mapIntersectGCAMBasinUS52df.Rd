% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{mapIntersectGCAMBasinUS52df}
\alias{mapIntersectGCAMBasinUS52df}
\title{Intersection of GCAM Basins and US 52 Regions.}
\format{
R tibble
}
\source{
JGCRI
}
\usage{
mapIntersectGCAMBasinUS52df
}
\description{
Intersection of GCAM Basins and US 52 Regions.
}
\examples{
\dontrun{
 library(sp); library(rmapdata); library(ggplot2)
 ggplot() +
 geom_polygon(data = mapIntersectGCAMBasinUS52df, aes(x = long, y = lat, group = group),
             colour = "black", fill = NA)
 head(mapIntersectGCAMBasinUS52df)
}
}
\keyword{datasets}
