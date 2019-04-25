#!/bin/bash
MIX=dev mix release 
cd priv/corto-site/
yarn
rm -rf build/
PUBLIC_URL=./ yarn build
cd -
rm -rf _build/dev/rel/corto/priv/ _build/dev/rel/corto/priv/corto-site
mkdir _build/dev/rel/corto/priv/
mkdir _build/dev/rel/corto/priv/corto-site
mv priv/corto-site/build/ _build/dev/rel/corto/priv/corto-site/
