# last updated: 2023-12-15
FROM rstudio/plumber:v1.2.0
LABEL org.opencontainers.image.authors="Docker User <docker@user.org>"

RUN R -e "install.packages(c('librarian','DBI','dplyr','glue','here','lubridate','readr','stringr','RPostgres'))"

RUN apt-get update -qq && apt-get install -y \
  libpq5

#   FROM rstudio/plumber:latest
#   RUN apt-get update -qq && apt-get install -y \
#     [list-your-debian-packages-here]
#   # add app files from host's present working dir
#   COPY . /api
#   # set default startup command to run the app's "plumber.R" file
#   CMD ["/api/plumber.R"]

# set default startup command to run the app's "plumber.R" file
CMD ["/share/github/ws-api/run_api.R"]
