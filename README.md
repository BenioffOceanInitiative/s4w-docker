# s4w-docker
Docker server software setup for Ships for Whales

## Install with Docker

### Software

- [WordPress](https://wordpress.com)
- [Shiny](https://shiny.rstudio.com)
- [RStudio](https://rstudio.com/products/rstudio/#rstudio-server)
- [GeoServer](http://geoserver.org)
- [PostGIS](https://postgis.net)

### References

- [Quickstart: Compose and WordPress | Docker Documentation](https://docs.docker.com/compose/wordpress/)
- [docker-compose.yml · kartoza/docker-geoserver](https://github.com/kartoza/docker-geoserver/blob/master/docker-compose.yml)

### Dependencies

- [Docker](https://docs.docker.com/engine/installation/)
- [Docker Compose](https://docs.docker.com/compose/install/)

### Installation

Run the following commands:

- NOTE: Set `PASSWORD`, substituting "CHANGEME" with password from [tech-aws notes | ship-strike - Google Docs](https://docs.google.com/document/d/1-iAlUOVzjw7Ejdlvmt2jVWdG6XhFqm13gWS3hZJ9mDc/edit#). The [docker-compose.yml](https://github.com/BenioffOceanInitiative/s4w-docker/blob/master/docker-compose.yml) uses [variable substitution in Docker](https://docs.docker.com/compose/compose-file/#variable-substitution).

```bash
PASSWORD=CHANGEME
git clone https://github.com/BenioffOceanInitiative/s4w-docker.git
cd s4w-docker
# git pull; docker-compose up --build -d
docker-compose up --build -d
docker-compose up
```

### Debugging

To tail the logs from the Docker containers in realtime, run:

```bash
docker-compose logs -f
```
