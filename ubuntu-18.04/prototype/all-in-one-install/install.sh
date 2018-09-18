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


## Install Table dayi4.db
#sudo cp dayi4.db /usr/share/ibus-table/tables/dayi4.db

## Change Owner
#sudo chown root.root /usr/share/ibus-table/tables/dayi4.db

## Change Mode
#sudo chmod 644 /usr/share/ibus-table/tables/dayi4.db


sudo install -m 644 -o root -g root dayi4.db /usr/share/ibus-table/tables/dayi4.db

ls /usr/share/ibus-table/tables/dayi4.db -l
