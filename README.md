OpenHIM config package
======================

This repo allows you to create a debian package that will automatically
configure the openhim-core server installed by the openhim-core debian package.

Getting started
---------------

Fork this repository to get copy of the template. Next execute `$ ./configure.sh`.
This will setup the package with a project name and initial version.

Once this is done, you will want to replace `targets/trusty/etc/openhim/data.json`
with a file that contains the configuration you want. You may create this by hand
or you may export the configuration directly from the OpenHIM-console using the
import/export function. Currently this package supports configuration of Clients,
Channels and Users.

Once the config is in place execute `.create-deb.sh` to create the package. This
script will ask you if you want to upload to launchpad or just create a .deb file.

The `load-initial-data.sh` script will be placed in `/etc/openhim/` along with the
data if you ever need to run it again.
