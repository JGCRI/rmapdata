#' saveDataFiles.R

#---------------------------
# Libraries Needed
#---------------------------
library(data.table)
library(usethis)
library(dplyr)
library(rmapdata)
library(rmap)

#-------------------
# Save Maps as ggplot dataframes
#-------------------

# Worldmap countries
#-------------------
mapx <- rmapdata::mapCountries
mapCountriesdf <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapCountriesdf %>% head()
use_data(mapCountriesdf, version=3,  overwrite=T)

# Worldmap states
#-------------------
mapx <- rmapdata::mapStates
mapStatesdf <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapStatesdf %>% head()
use_data(mapStatesdf, version=3,  overwrite=T)

#-----------------
# GCAM Maps (Regions, Basins, Land)
#-----------------

# GCAM 32 Regions
#------------------
mapx <- rmapdata::mapGCAMReg32
mapGCAMReg32df <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapGCAMReg32df %>% head()
use_data(mapGCAMReg32df, version=3,  overwrite=T)

# GCAM Basins
#------------------
mapx <- rmapdata::mapGCAMBasins
mapGCAMBasinsdf <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapGCAMBasinsdf %>% head()
use_data(mapGCAMBasinsdf, version=3,  overwrite=T)

# GCAM Land
#------------------
mapx <- rmapdata::mapGCAMLand
mapGCAMLanddf <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapGCAMLanddf %>% head()
use_data(mapGCAMLanddf, version=3,  overwrite=T)

#-----------------
# Hydrology Maps (HydroShed, HUC)
#-----------------
# Hydro sheds
# https://www.hydrosheds.org/page/hydrobasins
# Lehner, B., Grill G. (2013): Global river hydrography and network routing:
# baseline data and new approaches to study the world’s large river systems.
# Hydrological Processes, 27(15): 2171–2186. Data is available at www.hydrosheds.org

# HydroSheds Level 1
#-------------------
mapx <- rmapdata::mapHydroShed1
mapHydroShed1df <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapHydroShed1df %>% head()
use_data(mapHydroShed1df, version=3,  overwrite=T)

# HydroSheds Level 2#-------------------
mapx <- rmapdata::mapHydroShed2
mapHydroShed2df <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapHydroShed2df %>% head()
use_data(mapHydroShed2df, version=3,  overwrite=T)

# HydroSheds Level 3
#-------------------
mapx <- rmapdata::mapHydroShed3
mapHydroShed3df <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapHydroShed3df %>% head()
use_data(mapHydroShed3df, version=3,  overwrite=T)


# # HydroSheds Level 4
# #-------------------
# if(redoMaps){
# examplePolyFolder<-paste(dataFileFolder,"/gis/metis/subbasin_hydrobasin",sep="")
# examplePolyFile<-paste("hydrobasins_level_4",sep="")
# x=rgdal::readOGR(dsn=examplePolyFolder,layer=examplePolyFile,use_iconv=T,encoding='UTF-8')
# head(x@data); names(x@data)
# mapx <- x
# mapx@data <- mapx@data %>%
#   dplyr::select(subRegion=HYBAS_ID, SUB_AREA) %>%
#   dplyr::mutate(region="World",subRegionType="hydroshed4", subRegionAlt=subRegion,source="https://www.naturalearthdata.com/downloads/")
# head(mapx@data); mapx@data%>%distinct(region)%>%arrange(region)
# a<-tmaptools::simplify_shape(mapx, fact = 0.01)
# mapx <- as(sf::st_collection_extract(x = st_geometry(a),
#                                      type = "POLYGON"), "Spatial")
# format(object.size(mapx), units="Mb")
# # Need to Covnert this back to an spdf
# p.df <- data.frame( ID=1:length(mapx))
# pid <- sapply(slot(mapx, "polygons"), function(x) slot(x, "ID")) # Extract polygon ID's
# p.df <- data.frame( ID=1:length(mapx), row.names = pid) # Create dataframe with correct rownames
# p <- SpatialPolygonsDataFrame(mapx, p.df)
# p@data <- a%>%as.data.frame()%>%dplyr::select(-geometry)
# mapx<-p
# format(object.size(mapx), units="Mb")
# # sp::plot(mapx)
# # metis.map(dataPolygon=mapx,fillColumn = "subRegion",labels=F,printFig=F, facetsON=F,fileName = "HydroShed1")
# mapHydroShed4 <- mapx
# use_data(mapHydroShed4, version=3,  overwrite=T)
# }

# HUC USGS
# https://water.usgs.gov/GIS/huc.html
# https://datagateway.nrcs.usda.gov/Catalog/ProductDescription/WBD.html
# https://nrcs.app.box.com/v/huc

# USGS HUC Levels
# US52 HUC 2
#-------------------
mapx <- rmapdata::mapUS52HUC2
mapUS52HUC2df <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapUS52HUC2df %>% head()
use_data(mapUS52HUC2df, version=3,  overwrite=T)

# US49 HUC 2
#-------------------
mapx <- rmapdata::mapUS49HUC2
mapUS49HUC2df <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapUS49HUC2df %>% head()
use_data(mapUS49HUC2df, version=3,  overwrite=T)

# US52 HUC 4
#-------------------
mapx <- rmapdata::mapUS52HUC4
mapUS52HUC4df <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapUS52HUC4df %>% head()
use_data(mapUS52HUC4df, version=3,  overwrite=T)

# US49 HUC 4
#-------------------
mapx <- rmapdata::mapUS49HUC4
mapUS49HUC4df <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapUS49HUC4df %>% head()
use_data(mapUS49HUC4df, version=3,  overwrite=T)

#-----------------
# US Maps ( 52 State, 49 State, Counties, Regions, Grid Regions)
#-----------------

# US 52 (including Alaska, Hawaii and Puerto Rico)
#-------------------
mapx <- rmapdata::mapUS52
mapUS52df <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapUS52df %>% head()
use_data(mapUS52df, version=3,  overwrite=T)

# US 52 with Alaska (AK), Hawaii (HI) and Puerto Rico (PR) shrunken and shifted
#-------------------
mapx <- rmapdata::mapUS52Compact
mapUS52Compactdf <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapUS52Compactdf %>% head()
use_data(mapUS52Compactdf, version=3,  overwrite=T)


# US 49 (Excluding Alsaka, Hawaii and Puerto Rico)
#-------------------
mapx <- rmapdata::mapUS49
mapUS49df <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapUS49df %>% head()
use_data(mapUS49df, version=3,  overwrite=T)

# US 52 Counties
#-------------------
mapx <- rmapdata::mapUS52County
mapUS52Countydf <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapUS52Countydf %>% head()
use_data(mapUS52Countydf, version=3,  overwrite=T)

# US 52 Counties with Alaska (AK), Hawaii (HI) and Puerto Rico (PR) shrunken and shifted
#-------------------
mapx <- rmapdata::mapUS52CountyCompact
mapUS52CountyCompactdf <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapUS52CountyCompactdf %>% head()
use_data(mapUS52CountyCompactdf, version=3,  overwrite=T)

# US 49 Counties
#-------------------
mapx <- rmapdata::mapUS49County
mapUS49Countydf <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapUS49Countydf %>% head()
use_data(mapUS49Countydf, version=3,  overwrite=T)

# Merge
#-------------------
# Merge US52 with GCAM Regs
mapx <- rmapdata::mapGCAMReg32US52
mapGCAMReg32US52df <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapGCAMReg32US52df %>% head()
use_data(mapGCAMReg32US52df, version=3,  overwrite=T)


# Merge US52 with Countries file
mapx <- rmapdata::mapCountriesUS52
mapCountriesUS52df <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapCountriesUS52df %>% head()
use_data(mapCountriesUS52df, version=3,  overwrite=T)

# Merge Uruguay with GCAM Regs
mapx <- rmapdata::mapGCAMReg32Uruguay
mapGCAMReg32Uruguaydf <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapGCAMReg32Uruguaydf %>% head()
use_data(mapGCAMReg32Uruguaydf, version=3,  overwrite=T)

# Intersections
#-------------------

#mapx1 <- mapx[grepl("Ecuador",mapx@data$subRegion_Country),]; mapx1@data%>%head()%>%as.data.frame()

#Intersection of GCAM Basins and Countries
mapx <- rmapdata::mapIntersectGCAMBasinCountry
mapIntersectGCAMBasinCountrydf <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapIntersectGCAMBasinCountrydf %>% head()
use_data(mapIntersectGCAMBasinCountrydf, version=3,  overwrite=T)


# Intersection of GCAM Basins and 32 GCAM Regions
mapx <- rmapdata::mapIntersectGCAMBasin32Reg
mapIntersectGCAMBasin32Regdf <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapIntersectGCAMBasin32Regdf %>% head()
use_data(mapIntersectGCAMBasin32Regdf, version=3,  overwrite=T)

# Intersection of GCAM Basins and US 52 States
mapx <- rmapdata::mapIntersectGCAMBasinUS52
mapIntersectGCAMBasinUS52df <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapIntersectGCAMBasinUS52df %>% head()
use_data(mapIntersectGCAMBasinUS52df, version=3,  overwrite=T)

# Intersection of GCAM Basins and US 52 County
mapx <- rmapdata::mapIntersectGCAMBasinUS52County
mapIntersectGCAMBasinUS52Countydf <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapIntersectGCAMBasinUS52Countydf %>% head()
use_data(mapIntersectGCAMBasinUS52Countydf, version=3,  overwrite=T)

# Intersection of GCAM Basins and US 52 County
mapx <- rmapdata::mapIntersectGCAMBasinUS52County
mapIntersectGCAMBasinUS52Countydf <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapIntersectGCAMBasinUS52Countydf %>% head()
use_data(mapIntersectGCAMBasinUS52Countydf, version=3,  overwrite=T)

# Intersection of GCAM Basins and US 52 States
mapx <- rmapdata::mapIntersectGCAMBasin32RegUruguay
mapIntersectGCAMBasin32RegUruguaydf <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapIntersectGCAMBasin32RegUruguaydf %>% head()
use_data(mapIntersectGCAMBasin32RegUruguaydf, version=3,  overwrite=T)

# Cropped Files
#------------------------------

# Cropped GCAM Basins and US 52
mapx <- rmapdata::mapGCAMBasinsUS52
mapGCAMBasinsUS52df <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapGCAMBasinsUS52df %>% head()
use_data(mapGCAMBasinsUS52df, version=3,  overwrite=T)


# Cropped GCAM Basins and US 49 States
mapx <- rmapdata::mapGCAMBasinsUS49
mapGCAMBasinsUS49df <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapGCAMBasinsUS49df %>% head()
use_data(mapGCAMBasinsUS49df, version=3,  overwrite=T)

# Cropped GCAM Land and US 52
mapx <- rmapdata::mapGCAMLandUS52
mapGCAMLandUS52df <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapGCAMLandUS52df %>% head()
use_data(mapGCAMLandUS52df, version=3,  overwrite=T)

# Cropped GCAM Land and US 49 States
mapx <- rmapdata::mapGCAMLandUS49
mapGCAMLandUS49df <- rmapdata::tidy_shape(shape=mapx, shapeColum="subRegion") %>%
  dplyr::rename(subRegion=id)%>%
  dplyr::inner_join(mapx@data, by="subRegion") %>% dplyr::rename(lon=long) %>% dplyr::mutate(name = paste0(name,"df"));
mapGCAMLandUS49df %>% head()
use_data(mapGCAMLandUS49df, version=3,  overwrite=T)

#------------
# Pre-built map regions
#--------------

if(T){
# Renaming subregions in mapStates so that states with USPS can be plotted with states with full names in other countries
  mapStatesx <- rmapdata::mapStates
  mapStatesx@data <- mapStatesx@data %>%
    dplyr::mutate(
      subRegionAlt = as.character(subRegionAlt),
      subRegion = as.character(subRegion),
      subRegion1 = subRegionAlt,
      subRegionAlt = subRegion,
      subRegion = subRegion1,
      subRegion = dplyr::case_when(region != "USA" ~ subRegionAlt,
                                   TRUE ~ subRegion)
    ) %>%
    dplyr::select(-subRegion1)


  mapsSubRegions <- list(
    "subRegStates" =
    tolower(mapStatesx@data$subRegion %>% unique() %>% as.character %>% sort()),
  "subRegUS49" =
    tolower(rmapdata::mapUS49@data$subRegion %>% unique() %>% as.character %>% sort()),
  "subRegUS52" =
    tolower(rmapdata::mapUS52@data$subRegion %>% unique() %>% as.character %>% sort()),
  "subRegGCAMReg32" =
    tolower(rmapdata::mapGCAMReg32@data$subRegion %>% unique() %>% as.character %>%
              sort()),
  "subRegGCAMReg32Uruguay" =
    tolower(rmapdata::mapGCAMReg32Uruguay@data$subRegion %>% unique() %>% as.character %>%
              sort()),
  "subRegCountries" =
    tolower(rmapdata::mapCountries@data$subRegion %>% unique() %>% as.character %>%
              sort()),
  "subRegGCAMReg32US52" =
    tolower(rmapdata::mapGCAMReg32US52@data$subRegion %>% unique() %>% as.character %>%
              sort()),
  "subRegCountriesUS52" =
    tolower(rmapdata::mapCountriesUS52@data$subRegion %>% unique() %>% as.character %>%
              sort()),
  "subRegUS49County" =
    tolower(rmapdata::mapUS49County@data$subRegion %>% unique() %>% as.character %>%
              sort()),
  "subRegUS52County" =
    tolower(rmapdata::mapUS52County@data$subRegion %>% unique() %>% as.character %>%
              sort()),
  "subRegGCAMBasins" =
    tolower(rmapdata::mapGCAMBasins@data$subRegion %>% unique() %>% as.character %>%
              sort()),
  "subRegGCAMBasinsUS49" =
    tolower(rmapdata::mapGCAMBasinsUS49@data$subRegion %>% unique() %>% as.character %>%
              sort()),
  "subRegGCAMBasinsUS52" =
    tolower(rmapdata::mapGCAMBasinsUS52@data$subRegion %>% unique() %>% as.character %>%
              sort()),
  "subRegGCAMLand" =
    tolower(rmapdata::mapGCAMLand@data$subRegion %>% unique() %>% as.character %>%
              sort()),
  "subRegGCAMLandUS49" =
    tolower(rmapdata::mapGCAMLandUS49@data$subRegion %>% unique() %>% as.character %>%
              sort()),
  "subRegGCAMLandUS52" =
    tolower(rmapdata::mapGCAMLandUS52@data$subRegion %>% unique() %>% as.character %>%
              sort()),
  "subRegUS49HUC2" =
    tolower(rmapdata::mapUS49HUC2@data$subRegion %>% unique() %>% as.character %>%
              sort()),
  "subRegUS52HUC2" =
    tolower(rmapdata::mapUS52HUC2@data$subRegion %>% unique() %>% as.character %>%
              sort()),
  "subRegUS49HUC4" =
    tolower(rmapdata::mapUS49HUC4@data$subRegion %>% unique() %>% as.character %>%
              sort()),
  "subRegUS52HUC4" =
    tolower(rmapdata::mapUS52HUC4@data$subRegion %>% unique() %>% as.character %>%
              sort()),
  "mapIntersectGCAMBasin32Reg" =
    tolower(rmapdata::mapIntersectGCAMBasin32Reg@data$subRegion %>% unique() %>% as.character %>%
              sort()),
  "mapIntersectGCAMBasin32RegUruguay" =
    tolower(rmapdata::mapIntersectGCAMBasin32RegUruguay@data$subRegion %>% unique() %>% as.character %>%
              sort()),
  "mapIntersectGCAMBasinCountry" =
    tolower(rmapdata::mapIntersectGCAMBasinCountry@data$subRegion %>% unique() %>% as.character %>%
              sort()),
  "mapIntersectGCAMBasinUS52" =
    tolower(rmapdata::mapIntersectGCAMBasinUS52@data$subRegion %>% unique() %>% as.character %>%
              sort()),
  "mapIntersectGCAMBasinUS52County" =
    tolower(rmapdata::mapIntersectGCAMBasinUS52County@data$subRegion %>% unique() %>% as.character %>%
              sort()),
  # Alt Names
  "subRegStatesAlt" =
    tolower(mapStatesx@data$subRegionAlt %>% unique() %>% as.character %>% sort()),
  "subRegUS49Alt" =
    tolower(rmapdata::mapUS49@data$subRegionAlt %>% unique() %>% as.character %>%
              sort()),
  "subRegUS52Alt" =
    tolower(rmapdata::mapUS52@data$subRegionAlt %>% unique() %>% as.character %>%
              sort()),
  "subRegGCAMReg32Alt" =
    tolower(rmapdata::mapGCAMReg32@data$subRegionAlt %>% unique() %>% as.character %>%
              sort()),
  "subRegCountriesAlt" =
    tolower(rmapdata::mapCountries@data$subRegionAlt %>% unique() %>% as.character %>%
              sort()),
  "subRegGCAMReg32US52Alt" =
    tolower(rmapdata::mapGCAMReg32US52@data$subRegionAlt %>% unique() %>% as.character %>%
        sort()),
  "subRegCountriesUS52Alt" =
    tolower(rmapdata::mapCountriesUS52@data$subRegionAlt %>% unique() %>% as.character %>%
        sort()),
  "subRegUS49CountyAlt" =
    tolower(rmapdata::mapUS49County@data$subRegionAlt %>% unique() %>% as.character %>%
              sort()),
  "subRegUS52CountyAlt" =
    tolower(rmapdata::mapUS52County@data$subRegionAlt %>% unique() %>% as.character %>%
              sort()),
  "subRegGCAMBasinsAlt" =
    tolower(rmapdata::mapGCAMBasins@data$subRegionAlt %>% unique() %>% as.character %>%
              sort()),
  "subRegGCAMBasinsUS49Alt" =
    tolower(rmapdata::mapGCAMBasinsUS49@data$subRegionAlt %>% unique() %>% as.character %>%
        sort()),
  "subRegGCAMBasinsUS52Alt" =
    tolower(rmapdata::mapGCAMBasinsUS52@data$subRegionAlt %>% unique() %>% as.character %>%
        sort()),
  "subRegGCAMLandAlt" =
    tolower(rmapdata::mapGCAMLand@data$subRegionAlt %>% unique() %>% as.character %>%
              sort()),
  "subRegGCAMLandUS49Alt" =
    tolower(rmapdata::mapGCAMLandUS49@data$subRegionAlt %>% unique() %>% as.character %>%
        sort()),
  "subRegGCAMLandUS52Alt" =
    tolower(rmapdata::mapGCAMLandUS52@data$subRegionAlt %>% unique() %>% as.character %>%
        sort()),
  "subRegUS49HUC2Alt" =
    tolower(rmapdata::mapUS49HUC2@data$subRegionAlt %>% unique() %>% as.character %>%
              sort()),
  "subRegUS52HUC2Alt" =
    tolower(rmapdata::mapUS52HUC2@data$subRegionAlt %>% unique() %>% as.character %>%
              sort()),
  "subRegUS49HUC4Alt" =
    tolower(rmapdata::mapUS49HUC4@data$subRegionAlt %>% unique() %>% as.character %>%
              sort()),
  "subRegUS52HUC4Alt" =
    tolower(rmapdata::mapUS52HUC4@data$subRegionAlt %>% unique() %>% as.character %>%
              sort()),
  "mapIntersectGCAMBasin32RegAlt" =
    tolower(rmapdata::mapIntersectGCAMBasin32Reg@data$subRegionAlt %>% unique() %>% as.character %>%
              sort()),
  "mapIntersectGCAMBasin32RegUruguayAlt" =
    tolower(rmapdata::mapIntersectGCAMBasin32RegUruguay@data$subRegionAlt %>% unique() %>% as.character %>%
              sort()),
  "mapIntersectGCAMBasinCountryAlt" =
    tolower(rmapdata::mapIntersectGCAMBasinCountry@data$subRegionAlt %>% unique() %>% as.character %>%
              sort()),
  "mapIntersectGCAMBasinUS52Alt" =
    tolower(rmapdata::mapIntersectGCAMBasinUS52@data$subRegionAlt %>% unique() %>% as.character %>%
              sort()),
  "mapIntersectGCAMBasinUS52CountyAlt" =
    tolower(rmapdata::mapIntersectGCAMBasinUS52County@data$subRegionAlt %>% unique() %>% as.character %>%
              sort())
  )

  use_data(mapsSubRegions, version=3,  overwrite=T)
}
