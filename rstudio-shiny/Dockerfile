# `etc/cont-init.d/add: No such file or directory` with 4.0.0
#   https://github.com/rocker-org/rocker-versioned/issues/219#issuecomment-633680843
FROM rocker/geospatial:3.6.3
MAINTAINER "Ben Best" ben@ecoquants.com

# install extra packages 
RUN install2.r --error \
  # for shiny:
  dbplyr \
  DBI \
  DT \
  fs \
  glue \
  gstat \
  here \
  httpuv \
  leaflet \
  plumber \
  Rcpp \
  RColorBrewer \
  RPostgres \
  shiny \
  shinydashboard \
  units
  
  # already included: https://tidyverse.tidyverse.org
  #   dplyr
  #   lubridate
  #   stringr
  # already included: https://github.com/rocker-org/geospatial
  #   maptools
  #   raster
  #   rgdal
  #   rgeos
  #   sf
  #   sp
  #   tmap
  
# add Shiny, per https://github.com/rocker-org/rocker/issues/235#issuecomment-299036810
RUN export ADD=shiny && bash /etc/cont-init.d/add

# github repos
RUN mkdir -p /share/github
WORKDIR /share/github

RUN if [ ! -d "ws-api" ] ; then \
  git clone https://github.com/BenioffOceanInitiative/ws-api.git ; fi
RUN if [ ! -d "ws-apps" ] ; then \
  git clone https://github.com/BenioffOceanInitiative/ws-apps.git ; \
  ln -s /share/github/ws-apps/api-test /srv/shiny-server/api-test ; fi

# run api
#RUN Rscript /share/github/ws-api/run_api.R &

# bigquery to postgis script bq2pg.py
RUN apt-get update && apt install python3-pip
RUN pip3 install pandas sqlalchemy psycopg2 google-cloud-bigquery tzlocal
RUN ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
RUN apt-get -y install cron
RUN apt-get update; apt-get -y install cron
# Copy hello-cron file to the cron.d directory
COPY bq2pg_cron /etc/cron.d/bq2pg_cron
# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/bq2pg_cron
# Apply cron job
RUN crontab /etc/cron.d/bq2pg_cron
# Create the log file to be able to run tail
RUN touch /share/bq2pg_log.txt
RUN service cron start
