# s4w-docker
Docker server software setup for Ships for Whales

## Install with Docker

### Software

- [PostGIS](https://postgis.net)
  - docker: [kartoza/postgis:11.0-2.5](https://hub.docker.com/r/kartoza/postgis)
- [GeoServer](http://geoserver.org)
  - docker: [kartoza/geoserver:2.15.2](https://hub.docker.com/r/kartoza/geoserver)
- [Shiny](https://shiny.rstudio.com)
- [RStudio](https://rstudio.com/products/rstudio/#rstudio-server)
- [WordPress](https://wordpress.com)

References:

- [docker-geoserver/docker-compose.yml at master · kartoza/docker-geoserver](https://github.com/kartoza/docker-geoserver/blob/master/docker-compose.yml)
- [Quickstart: Compose and WordPress | Docker Documentation](https://docs.docker.com/compose/wordpress/)

### Dependencies

- [Docker](https://docs.docker.com/engine/installation/)
- [Docker Compose](https://docs.docker.com/compose/install/)

### Installation

Run the following commands. Set `PASSWORD`, substituting "CHANGEME" with password from [tech-aws notes | ship-strike - Google Docs](https://docs.google.com/document/d/1-iAlUOVzjw7Ejdlvmt2jVWdG6XhFqm13gWS3hZJ9mDc/edit#). Script below uses [variable substitution in Docker](https://docs.docker.com/compose/compose-file/#variable-substitution).

```bash
PASSWORD=CHANGEME
git clone https://github.com/BenioffOceanInitiative/s4w-docker.git
cd s4w-docker
docker-compose up --build -d
docker-compose up
```

### Debugging

To tail the logs from the Docker containers in realtime, run:

```bash
docker-compose logs -f
```
