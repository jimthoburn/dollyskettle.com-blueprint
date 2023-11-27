#!/bin/bash

echo "- - - - - - - - - - - - - - - - - - - - - - -"
echo "Adding environment for deno"
echo "- - - - - - - - - - - - - - - - - - - - - - -"

rm -f /home/deno/git-repository/.env
echo AUTHORIZATION_HEADER_VALUE=\"$AUTHORIZATION_HEADER_VALUE\" >> /home/deno/git-repository/.env

echo "- - - - - - - - - - - - - - - - - - - - - - -"
echo "Running deno task build"
echo "- - - - - - - - - - - - - - - - - - - - - - -"

cd /home/deno/git-repository && deno task build
