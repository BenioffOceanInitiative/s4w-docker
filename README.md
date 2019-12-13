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


Accessing Amazon EC2:

- Connect to UCSB VPN
- SSH, eg for Ben:

```
ssh -i ~/.ssh/id_rsa.pem bbest@ec2-52-27-163-27.us-west-2.compute.amazonaws.com
```

On Amazon server:

```bash
uname -a
# Linux ip-10-242-0-52 4.15.0-1051-aws #53-Ubuntu SMP Wed Sep 18 13:35:53 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

# TODO: add user to docker group
sudo usermod -aG docker bbest

# OLD
sudo snap install docker
sudo snap uninstall docker

# NEW
# https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04

sudo apt-get update
sudo apt install docker.io

# start & run at startup
sudo systemctl start docker
sudo systemctl enable docker
docker -v
# where is it?!
# ok, removing
sudo apt remove docker.io

# NEW2 ----
# https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04
sudo apt update

# install a few prerequisite packages which let apt use packages over HTTPS:
sudo apt install apt-transport-https ca-certificates curl software-properties-common

# add the GPG key for the official Docker repository to your system:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker repository to APT sources:
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

# update the package database with the Docker packages from the newly added repo:
sudo apt update

# make sure you are about to install from the Docker repo instead of the default Ubuntu repo:
apt-cache policy docker-ce

# install Docker:
sudo apt install docker-ce

# Docker should now be installed, the daemon started, and the process enabled to start on boot. Check that it’s running:
sudo systemctl status docker

# If you want to avoid typing sudo whenever you run the docker command, add your username to the docker group:
sudo usermod -aG docker ${USER}


# To apply the new group membership, log out of the server and back in, or type the following:
su - ${USER}

# install docker-compose ----
# https://www.digitalocean.com/community/tutorials/how-to-install-docker-compose-on-ubuntu-18-04
# https://docs.docker.com/compose/install/

# download current stable release
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose


# apply executable permissions to the binary
sudo chmod +x /usr/local/bin/docker-compose

# test the installation
docker-compose --version


sudo systemctl stop docker
sudo mv /var/lib/docker /data/docker
sudo ln -s /data/docker /var/lib/docker
sudo systemctl start docker
```

```
(aws-s4w) Couldn't determine your account Default VPC ID : "UnauthorizedOperation: You are not authorized to perform this operation.\n\tstatus code: 403, request id: 68376987-0171-4555-bef0-5952163e2b0e"
Error setting machine configuration from flags provided: amazonec2 driver requires either the --amazonec2-subnet-id or --amazonec2-vpc-id option or an AWS Account with a default vpc-id
```


### Installation

Run the following commands:

- NOTE: Set `PASSWORD`, substituting "CHANGEME" with password from [tech-aws notes | ship-strike - Google Docs](https://docs.google.com/document/d/1-iAlUOVzjw7Ejdlvmt2jVWdG6XhFqm13gWS3hZJ9mDc/edit#). The [docker-compose.yml](https://github.com/BenioffOceanInitiative/s4w-docker/blob/master/docker-compose.yml) uses [variable substitution in Docker](https://docs.docker.com/compose/compose-file/#variable-substitution).

```bash
echo "PASSWORD=CHANGEME" > .env
git clone https://github.com/BenioffOceanInitiative/s4w-docker.git
cd ~/s4w-docker
# git pull; docker-compose up --build -d
docker-compose up --build -d
```

```
Creating network "s4w-docker_default" with the default driver
Creating volume "s4w-docker_geodb-backups" with default driver
Creating volume "s4w-docker_geoserver-data" with default driver
Creating volume "s4w-docker_geodb-data" with default driver
Creating volume "s4w-docker_cmsdb-data" with default driver
Creating volume "s4w-docker_shiny-apps" with default driver
Pulling nginx-proxy (jwilder/nginx-proxy:)...
latest: Pulling from jwilder/nginx-proxy
8d691f585fa8: Pull complete
5b07f4e08ad0: Pull complete
abc291867bca: Pull complete
11bb65fd10b6: Pull complete
d243c33ab4b8: Pull complete
de4ade85de29: Pull complete
ea87ccd037b1: Pull complete
0d77773cc78b: Pull complete
037b89e46b92: Pull complete
551c18274a6e: Pull complete
Digest: sha256:dfc0666b9747a6fc851f5fb9b03e65e957b34c95d9635b4b5d1d6b01104bde28
Status: Downloaded newer image for jwilder/nginx-proxy:latest
Pulling geodb (kartoza/postgis:11.0-2.5)...

...

Building rstudio
Step 1/5 : FROM rocker/geospatial:latest
latest: Pulling from rocker/geospatial
844c33c7e6ea: Pull complete
285420213b6b: Pull complete
c5734b22ae1e: Extracting [================================>                  ]  113.1MB/174MB
c7181c71e235: Download complete
1ff16416a792: Download complete
049690ad349d: Download complete
4fa28c20bdf0: Download complete
a07f2306779c: Download complete
542f1ee19bfc: Downloading [==================================================>]    413MB/413MB
6ba21f1af751: Downloading [==================================================>]  499.6MB/499.6MB
ERROR: Service 'rstudio' failed to build: write /var/lib/docker/tmp/GetImageBlob358267602: no space left on device
```

```
df -h
```

```
Filesystem      Size  Used Avail Use% Mounted on
udev            3.8G     0  3.8G   0% /dev
tmpfs           763M  800K  762M   1% /run
/dev/nvme1n1p1  7.7G  5.8G  2.0G  76% /
tmpfs           3.8G     0  3.8G   0% /dev/shm
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs           3.8G     0  3.8G   0% /sys/fs/cgroup
/dev/loop1       18M   18M     0 100% /snap/amazon-ssm-agent/1480
/dev/nvme0n1     50G   84M   50G   1% /data
/dev/loop4       90M   90M     0 100% /snap/core/8213
/dev/loop0       90M   90M     0 100% /snap/core/8268
tmpfs           763M     0  763M   0% /run/user/1002
```

50GB volume mounted on /data



```bash
docker-compose up
```

### Debugging

To tail the logs from the Docker containers in realtime, run:

```bash
docker-compose logs -f
```
