library(rmapdata); library(dplyr); library(ggplot2)

# Test Simple Map Direct
if(T){
  rmapdata::map(data=rmapdata::mapUS49,
            folder="rmapdataTEST_shape",
            labels = T, labelSize =3, labelFill="white",labelRepel=0,labelAlpha = 0.4)

  rmapdata::map(data=rmapdata::mapStatesdf%>%dplyr::filter(region=="Pakistan")%>%droplevels(),
            folder="rmapdataTEST_shape",
            labels = T, labelSize =3, labelFill="white",labelRepel=0,labelAlpha = 0.4)
}

