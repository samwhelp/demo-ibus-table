#!/usr/bin/env bash


## Prepare
sudo apt-get install ibus ibus-table sqlite3


## IM Switch
#im-config -n ibus


## Download
wget -c 'https://www.ubuntu-tw.org/modules/newbb/dl_attachment.php?attachid=1537102967&post_id=360356' -O dayi4-ibus.cin


## Create DB
ibus-table-createdb -s dayi4-ibus.cin -n dayi4.db


## Fix char_prompts
sqlite3 -line dayi4.db <<EOF
UPDATE ime
SET val='{''='': ''符'',''\`'': ''巷'', ''-'': ''鄉'', ''['': ''路'', '']'': ''街'', "''": ''號'', ''\\\\'': ''鎮'', '','': ''力'', ''.'': ''點'', ''/'': ''竹'', ''0'': ''金'', ''1'': ''言'', ''2'': ''牛'', ''3'': ''目'', ''4'': ''四'', ''5'': ''王'', ''6'': ''門'', ''7'': ''田'', ''8'': ''米'', ''9'': ''足'', '';'': ''虫'', ''a'': ''人'', ''b'': ''馬'', ''c'': ''七'', ''d'': ''日'', ''e'': ''一'', ''f'': ''土'', ''g'': ''手'', ''h'': ''鳥'', ''i'': ''木'', ''j'': ''月'', ''k'': ''立'', ''l'': ''女'', ''m'': ''雨'', ''n'': ''魚'', ''o'': ''口'', ''p'': ''耳'', ''q'': ''石'', ''r'': ''工'', ''s'': ''革'', ''t'': ''糸'', ''u'': ''艸'', ''v'': ''禾'', ''w'': ''山'', ''x'': ''水'', ''y'': ''火'', ''z'': ''心'', ''~'': ''～'', ''!'': ''！'', ''@'': ''＠'', ''#'': ''＃'', ''$'': ''＄'', ''%'': ''％'', ''^'': ''︿'', ''&'': ''＆'', ''*'': ''＊'', ''('': ''（'', '')'': ''）'', ''_'': ''ˍ'', ''+'': ''＋'', ''{'': ''｛'', ''}'': ''｝'', ''|'': ''｜'', '':'': ''：'', ''"'': ''”'', ''<'': ''＜'', ''>'': ''＞'', ''?'': ''？''}'
WHERE attr='char_prompts';
EOF


## Fix valid_input_chars
sqlite3 -line dayi4.db <<EOF
UPDATE ime
SET val='1234567890-abcdefghijklmnopqrstuvwxyz,./;''[]\\\`-~!@#$%^&*()_+{}|:"<>?='
WHERE attr='valid_input_chars'
EOF


## Config triggers
gsettings set org.freedesktop.ibus.general.hotkey triggers "['<Control>space']"


## Config preload-engines
gsettings set org.freedesktop.ibus.general preload-engines "['xkb:us::eng', 'table:dayi4']"


## Build Debian Package
mkdir -p var/ibus-table-dayi4/usr/share/ibus-table/tables/

cp dayi4.db var/ibus-table-dayi4/usr/share/ibus-table/tables/

mkdir -p var/ibus-table-dayi4/DEBIAN

cd var

cat > ibus-table-dayi4/DEBIAN/postinst << EOF
#!/bin/sh

set -e

echo "gsettings set org.freedesktop.ibus.general.hotkey triggers \"['<Control>space']\""
gsettings set org.freedesktop.ibus.general.hotkey triggers "['<Control>space']"

echo "gsettings set org.freedesktop.ibus.general preload-engines \"['xkb:us::eng', 'table:dayi4']\""
gsettings set org.freedesktop.ibus.general preload-engines "['xkb:us::eng', 'table:dayi4']"

EOF

chmod 755 ibus-table-dayi4/DEBIAN/postinst


cat > ibus-table-dayi4/DEBIAN/postrm << EOF
#!/bin/sh

set -e

echo "gsettings set org.freedesktop.ibus.general preload-engines \"['xkb:us::eng']\""
gsettings set org.freedesktop.ibus.general preload-engines "['xkb:us::eng']"

EOF

chmod 755 ibus-table-dayi4/DEBIAN/postrm


cat > ibus-table-dayi4/DEBIAN/control << EOF
Package: ibus-table-dayi4
Version: 0.1
Architecture: all
Description: dayi4 for ibus.
Maintainer: developer <developer@hell.heaven>
Depends: ibus, ibus-table

EOF

dpkg -b ibus-table-dayi4


## Install Debian Package
sudo dpkg -i ibus-table-dayi4.deb

## Package Installed Info ibus-table-dayi4
dpkg -l ibus-table-dayi4

dpkg -L ibus-table-dayi4
