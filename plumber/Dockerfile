FROM rstudio/plumber:v1.2.0  # last updated: 2023-12-15

RUN R -e "install.packages('DBI','dplyr','glue','here','lubridate','readr','stringr','RPostgres')"

CMD ["/share/github/ws-api/run_api.R"]