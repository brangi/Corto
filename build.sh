#!/bin/bash


mix deps.get
cd priv/corto-site/
yarn
rm -rf build/
PUBLIC_URL=./ yarn build
cd -
iex -S mix  phx.server
