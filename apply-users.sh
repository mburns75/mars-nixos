#!/bin/sh
pushd ~/.dotfiles
nix build .#homeManagerConfigurations.dvader.activationPackage
./result/activate
popd
