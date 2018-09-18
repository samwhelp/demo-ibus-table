#!/usr/bin/env bash


#man im-config
echo "im-config -n ibus"
im-config -n ibus
#im-config -n REMOVE

echo "cat \$HOME/.xinputrc"
cat "$HOME/.xinputrc"
