FROM ghcr.io/rocker-org/geospatial:latest

# COPY scripts /rocker_scripts
# RUN ls -la /
# RUN ls -la .
# RUN ls -la scripts
# RUN ls -la rocker_scripts

# https://github.com/rocker-org/rocker-versioned2/tree/master/scripts
RUN /rocker_scripts/install_python.sh
RUN /rocker_scripts/install_quarto.sh
RUN /rocker_scripts/install_shiny_server.sh
EXPOSE 3838

# install extra packages 
RUN install2.r --error \
  bslib \
  dbplyr \
  DBI \
  DT \
  fs \
  glue \
  gstat \
  here \
  httr2 \
  htmltools \
  httpuv \
  leaflet \
  librarian \
  lubridate \
  plumber \
  readr \
  reticulate \
  rhandsontable \
  Rcpp \
  RColorBrewer \
  RPostgres \
  shiny \
  shinydashboard \
  shinyjs \
  shinyWidgets \
  tidyverse \
  viridis \
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

# install packages for ws-api/bq2pg.py
RUN R -q -e 'reticulate::py_install(c("pandas", "pyarrow", "google-cloud-bigquery", "tzlocal", "pandas-gbq", "pyarrow", "sqlalchemy", "psycopg2-binary", "python-dateutil", "oauth2client", "google-auth-httplib2", "google-auth-oauthlib", "google-api-python-client"))'

# bigquery to postgis script bq2pg.py
RUN apt-get update && apt-get install -y cron python3-pip
# RUN pip3 install pandas sqlalchemy psycopg2 google-cloud-bigquery tzlocal
RUN ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
COPY bq2pg_cron /etc/cron.d/bq2pg_cron
RUN chmod 0644 /etc/cron.d/bq2pg_cron
RUN crontab /etc/cron.d/bq2pg_cron
RUN touch /share/bq2pg_log.txt
RUN service cron start
