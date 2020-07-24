#!/usr/bin/env sh

# build
zola build

# navigate into the build output directory
cd ./public

git init
git add -A
git commit -m 'upload'

git push -f https://github.com/thunderbiscuit/learn-bitcoin-testnet.git master:gh-pages

cd -
