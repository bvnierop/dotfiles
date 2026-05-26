#! /bin/bash

for dir in `find * -maxdepth 0 -type d -not -path '*/.*' -not -path '.'`
do
    echo "Uninstalling '${dir}'"
    stow -D --dotfiles "${dir}"
done
