FROM rocker/geospatial:latest
MAINTAINER "Ben Best" ben@ecoquants.com

# install extra packages 
RUN install2.r --error \
  # for shiny:
  Rcpp \
  httpuv \
  shiny \
  # for app: https://github.com/BenioffOceanInitiative/ships4whales-app/blob/master/shiny_ships/app.R
  dbplyr \
  fs \
  glue \
  gstat \
  here \
  leaflet \
  plumber \
  units \
  RColorBrewer \
  RPostgreSQL \
  RPostgres \
  shinydashboard
  
  # already included: https://tidyverse.tidyverse.org
  #   dplyr
  #   lubridate
  # already included: https://github.com/rocker-org/geospatial
  #   maptools
  #   raster
  #   rgdal
  #   rgeos
  #   sf
  #   sp
  #   tmap
  
# add Shiny, per https://github.com/rocker-org/rocker/issues/235#issuecomment-299036810
# RUN export ADD=shiny && bash /etc/cont-init.d/add
# BB error 2020-06-12: bash: /etc/cont-init.d/add: No such file or directory
#   so inserting "ADD: shiny" into docker-compose.yml
# EXPOSE 8888

# install Shiny apps
#RUN cd /srv && rm -rf shiny-server && \
#    git clone https://github.com/BenioffOceanInitiative/ws-apps.git shiny-server
    
# install api using plumber
#RUN cd /srv && git clone https://github.com/BenioffOceanInitiative/ws-api.git \
#  ws-api 

# install whalesafe4r
#RUN cd /srv && git clone https://github.com/BenioffOceanInitiative/whalesafe4r.git \
#  whalesafe4r 

#COPY symlinks.sh /srv/symlinks.sh 
#RUN chmod +x /srv/symlinks.sh 

# TODO: run multiple services more elegantly
# https://docs.docker.com/config/containers/multi-service_container/
# CMD /init & Rscript /srv/ws-api/run_api.R
# CMD /init
# THEN after logging into rstudio.ships4whales.org, Terminal:
#   Rscript /srv/ws-api/run_api.R &
