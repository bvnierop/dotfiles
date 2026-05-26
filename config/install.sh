#! /bin/bash

for dir in `find * -maxdepth 0 -type d -not -path '*/.*' -not -path '.'`
do
    echo "Installing '${dir}'"
    stow --dotfiles --no-folding "${dir}"
done
