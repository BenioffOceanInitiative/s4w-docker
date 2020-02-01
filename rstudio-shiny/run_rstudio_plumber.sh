#!/bin/sh

# source of this script: https://docs.docker.com/config/containers/multi-service_container/

# start Rstudio
/init -D
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start Rstudio: $status"
  exit $status
fi

# start Plumber
Rscript $PLUMBER_R -D
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start Plumber $PLUMBER_R: $status"
  exit $status
fi

# Naive check runs checks once a minute to see if either of the processes exited.
# This illustrates part of the heavy lifting you need to do if you want to run
# more than one service in a container. The container exits with an error
# if it detects that either of the processes has exited.
# Otherwise it loops forever, waking up every 60 seconds

while sleep 60; do
  ps aux | grep rstudio-server | grep -q -v grep
  RSTUDIO_STATUS=$?
  ps aux | grep $PLUMBER_R | grep -q -v grep
  PLUMBER_STATUS=$?
  # If the greps above find anything, they exit with 0 status
  # If they are not both 0, then something is wrong
  if [ $RSTUDIO_STATUS -ne 0 -o $PLUMBER_STATUS -ne 0 ]; then
    echo "One of the processes has already exited."
    exit 1
  fi
done