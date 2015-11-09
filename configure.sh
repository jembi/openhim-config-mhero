#!/bin/bash
# Exit on error
set -e

echo -n "What is the name of your project? (lowercase, no spaces): "
read PROJECT

echo -n "Enter a version for this config package: [0.1.0] "
read VER

if [[ $VER == "" ]]; then
  VER=0.1.0
fi

PKG="openhim-config-"$PROJECT

sed -i -e "s/^PKG=.*/PKG=$PKG/" create-deb.sh
sed -i -e "s/^PKGVER=.*/PKGVER=$VER/" create-deb.sh
sed -r -i -e "s/openhim-config-\S+/$PKG/" targets/trusty/debian/control
sed -r -i -e "s/Description: OpenHIM Config for .+/Description: OpenHIM Config for $PROJECT/" targets/trusty/debian/control
sed -r -i -e "s/openhim-config-\S+ \(.+-1~trusty\)/$PKG ($VER-1~trusty)/" targets/trusty/debian/changelog

echo "Done! Now, add your initial config data here: targets/trusty/etc/openhim/data.json"
