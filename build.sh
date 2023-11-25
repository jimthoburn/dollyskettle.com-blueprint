#!/bin/bash

# Make this script fail if any of the following steps fail
# https://stackoverflow.com/questions/821396/aborting-a-shell-script-if-any-command-returns-a-non-zero-value
# set -Eeuo pipefail

# Call `build-site.sh` each time a new build is requested,
# while only only building if a build is not already in progress,
# and only queueing a build if a build is not already queued.

echo "- - - - - - - - - - - - - - - - - - - - - - -"
echo "Adding build to queue"
echo "- - - - - - - - - - - - - - - - - - - - - - -"

rm -f /home/deno/build.queued
echo "build requested" >> /home/deno/build.queued

if [ -e "/home/deno/build.lock" ]
then
  echo "- - - - - - - - - - - - - - - - - - - - - - -"
  echo "Build is already in progress. Waiting to build..."
  echo "- - - - - - - - - - - - - - - - - - - - - - -"
else
  rm -f /home/deno/build.queued

  echo "- - - - - - - - - - - - - - - - - - - - - - -"
  echo "Starting build"
  echo "- - - - - - - - - - - - - - - - - - - - - - -"

  echo "building" >> /home/deno/build.lock
  cp /home/deno/_public/build-status-in-progress.svg /home/deno/git-repository/_site/build-status.svg
  bash /home/deno/build-site.sh
  cp /home/deno/_public/build-status-finished.svg /home/deno/git-repository/_site/build-status.svg
  rm -f /home/deno/build.lock

  echo "- - - - - - - - - - - - - - - - - - - - - - -"
  echo "Finished building"
  echo "- - - - - - - - - - - - - - - - - - - - - - -"

  if [ -e "/home/deno/build.queued" ]
  then
    echo "- - - - - - - - - - - - - - - - - - - - - - -"
    echo "A new build is queued. Starting the build process again..."
    echo "- - - - - - - - - - - - - - - - - - - - - - -"

    bash /home/deno/build.sh
  fi
fi
