#!/usr/bin/env bash

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
