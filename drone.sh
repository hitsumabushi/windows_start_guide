#!/usr/bin/env bash
set -x

# package install
sudo apt-get update -qq
sudo apt-get install pandoc

# resolv dependency
pip install -r requirements.txt --use-mirrors

# build html
make clean && make html

# checkout branch
git checkout -b gh-pages

# copy output to top of repository
mv build /tmp
mv .git /tmp

# Remove unpublish files
rm -rf *
rm -rf .*
mv /tmp/.git .
git checkout gh-pages
mv /tmp/build/* .

# Git push
git add -A .
git commit -m "Build by drone.io"
git remote set-url origin git@github.com:hitsumabushi/windows_start_guide.git
git push -f origin gh-pages  # forced push

