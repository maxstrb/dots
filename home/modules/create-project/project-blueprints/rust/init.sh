#!/usr/bin/env bash

nix develop . --command bash -c "cargo new $1"

cp -r "$1"/* .

rm -fr "$1"
