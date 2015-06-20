#!/usr/bin/env bash
set -x

# pandoc install
## need >= v1.11 : trusty has v1.12 pandoc
sudo sed -i.back -e 's/precise/trusty/g' /etc/apt/sources.list
sudo apt-get update -qq
sudo apt-get install pandoc

# Add cabal PATH
export PATH=${HOME}/.cabal/bin:${PATH}

# resolv dependency
pip install -r requirements.txt --use-mirrors

# build html
make clean && make html

# checkout branch
git checkout -b gh-pages

# copy output to top of repository
mv build/html /tmp
mv .git /tmp

# Remove unpublish files
rm -rf *
rm -rf .*
mv /tmp/.git .
git checkout gh-pages
mv /tmp/html/* .
touch .nojekyll

# Git push
git add -A .
git commit -m "Build by drone.io"
git remote set-url origin git@github.com:hitsumabushi/windows_start_guide.git
git push -f origin gh-pages  # forced push

