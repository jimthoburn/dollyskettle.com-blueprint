#!/bin/bash

# Avoid “Another git process seems to be running in this repository” error
rm -f /home/deno/git-repository/.git/index.lock

# If the repository has been set up
if [ -d "/home/deno/git-repository/.git" ]
then
  # Run a script, without waiting for it to finish (since waiting for this step may cause the deploy to time out)
  # https://unix.stackexchange.com/questions/86247/what-does-ampersand-mean-at-the-end-of-a-shell-script-line#answer-86253
  bash /home/deno/update.sh &
else
  bash /home/deno/setup.sh

  # Run a script, without waiting for it to finish (since waiting for this step may cause the deploy to time out)
  # https://unix.stackexchange.com/questions/86247/what-does-ampersand-mean-at-the-end-of-a-shell-script-line#answer-86253
  bash /home/deno/pull-images-and-build.sh &
fi

# Hand off to the CMD
exec "$@"
