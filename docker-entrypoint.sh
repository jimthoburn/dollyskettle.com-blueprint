#!/bin/bash

# Avoid “Another git process seems to be running in this repository” error
rm -f /home/deno/git-repository/.git/index.lock

# If the repository has been set up
if [ -d "/home/deno/git-repository/.git" ]
then
  echo "Repository already set up"
else
  bash /home/deno/setup.sh
fi

# Hand off to the CMD
exec "$@"
