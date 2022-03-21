#!/bin/bash
set -e
set -o pipefail

export WORLD=$HOME/.minetest/worlds/minenews-dev
export LOGS=$(mktemp "$WORLD/debug.txt")

rm -rvf $WORLD
mkdir -p $WORLD/worldmods
cp -r scripts/{world.mt,minetest.conf,news*} $WORLD/
cp -r ./ $WORLD/worldmods/minenews
exec minetest --verbose --config $WORLD/minetest.conf --logfile $LOGS --world $WORLD --go