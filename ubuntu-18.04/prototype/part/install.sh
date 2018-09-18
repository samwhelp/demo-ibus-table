#!/usr/bin/env bash


## Install Table dayi4.db
#sudo cp dayi4.db /usr/share/ibus-table/tables/dayi4.db

## Change Owner
#sudo chown root.root /usr/share/ibus-table/tables/dayi4.db

## Change Mode
#sudo chmod 644 /usr/share/ibus-table/tables/dayi4.db


sudo install -m 644 -o root -g root dayi4.db /usr/share/ibus-table/tables/dayi4.db
