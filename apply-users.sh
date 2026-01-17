#!/bin/sh
pushd ~/.dotfiles
home-manager switch -f ./users/dvader/home.nix
popd
