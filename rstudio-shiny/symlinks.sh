#!/bin/bash
ln -s /srv/ws-api           /home/admin/plumber-api
ln -s /srv/shiny-server     /home/admin/shiny-apps
ln -s /srv/whalesafe4r      /home/admin/whalesafe4r
ln -s /var/log/shiny-server /home/admin/shiny-logs
chown -R admin /srv/ws-api
chown -R admin /srv/whalesafe4r
chown -R admin /srv/shiny-server
