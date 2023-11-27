#!/bin/bash

# Make this script fail if any of the following steps fail
# https://stackoverflow.com/questions/821396/aborting-a-shell-script-if-any-command-returns-a-non-zero-value
set -Eeuo pipefail

echo "- - - - - - - - - - - - - - - - - - - - - - -"
echo "Starting reset"
echo "- - - - - - - - - - - - - - - - - - - - - - -"

echo "- - - - - - - - - - - - - - - - - - - - - - -"
echo "Configure Git"
echo "- - - - - - - - - - - - - - - - - - - - - - -"

git config --global user.email $GITHUB_USER_EMAIL
git config --global user.name "$GITHUB_USER_NAME"
# https://stackoverflow.com/questions/73485958/how-to-correct-git-reporting-detected-dubious-ownership-in-repository-withou
git config --global --add safe.directory /home/deno/git-repository
git lfs install

cp /etc/secrets/id_ed25519 /home/deno/.ssh/id_ed25519
cp /etc/secrets/id_ed25519.pub /home/deno/.ssh/id_ed25519.pub
cp /etc/secrets/known_hosts /home/deno/.ssh/known_hosts

# https://unix.stackexchange.com/questions/31947/how-to-add-a-newline-to-the-end-of-a-file
sed -i -e '$a\' /home/deno/.ssh/id_ed25519
sed -i -e '$a\' /home/deno/.ssh/id_ed25519.pub
sed -i -e '$a\' /home/deno/.ssh/known_hosts

chmod 600 /home/deno/.ssh/id_ed25519
chmod 600 /home/deno/.ssh/id_ed25519.pub
chmod 600 /home/deno/.ssh/known_hosts

eval "$(ssh-agent -s)"

echo "- - - - - - - - - - - - - - - - - - - - - - -"
echo "cd to /home/deno/git-repository"
echo "- - - - - - - - - - - - - - - - - - - - - - -"

cd /home/deno/git-repository

echo "- - - - - - - - - - - - - - - - - - - - - - -"
echo "Check git status"
echo "- - - - - - - - - - - - - - - - - - - - - - -"

git status

echo "- - - - - - - - - - - - - - - - - - - - - - -"
echo "Discard any local changes"
echo "- - - - - - - - - - - - - - - - - - - - - - -"

git reset --hard
git clean -d --force

echo "- - - - - - - - - - - - - - - - - - - - - - -"
echo "Get latest files and content"
echo "- - - - - - - - - - - - - - - - - - - - - - -"

git pull --rebase --autostash

echo "- - - - - - - - - - - - - - - - - - - - - - -"
echo "Finished reseting"
echo "- - - - - - - - - - - - - - - - - - - - - - -"
