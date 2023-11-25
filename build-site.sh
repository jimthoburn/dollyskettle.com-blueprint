#!/bin/bash

# Make this script fail if any of the following steps fail
# https://stackoverflow.com/questions/821396/aborting-a-shell-script-if-any-command-returns-a-non-zero-value
# set -Eeuo pipefail

echo "- - - - - - - - - - - - - - - - - - - - - - -"
echo "Adding environment for deno"
echo "- - - - - - - - - - - - - - - - - - - - - - -"

rm -f /home/deno/git-repository/.env
echo AUTHORIZATION_HEADER_VALUE=\"$AUTHORIZATION_HEADER_VALUE\" >> /home/deno/git-repository/.env

echo "- - - - - - - - - - - - - - - - - - - - - - -"
echo "Running deno task build"
echo "- - - - - - - - - - - - - - - - - - - - - - -"

cd /home/deno/git-repository && deno task build
