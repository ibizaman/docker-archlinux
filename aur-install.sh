#!/bin/bash

set -e # makes the build stop on first failure

package=$1
build_dir=/tmp/nobody

mkdir -p "$build_dir"
chown nobody: "$build_dir"
pushd "$build_dir" &> /dev/null

su nobody -c "curl https://aur.archlinux.org/cgit/aur.git/snapshot/$package.tar.gz | tar zx"

pushd "$build_dir"/$package &> /dev/null
su nobody -c "makepkg --noconfirm"
pacman --upgrade --noconfirm *.xz

popd &> /dev/null
rm -rf "$build_dir"/$package

popd &> /dev/null
