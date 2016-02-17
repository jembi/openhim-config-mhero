OpenHIM mHero config package
============================

This repository creates an OpenHIM config package for the mHero project. You can
find more details about this project [here](http://mhero.org/).

It has been configured specifically for the mHero project. If you would like to
create a config package for the OpenHIM for your own project, then
[see here](https://github.com/jembi/openhim-config-pkg).

After installing the package
----------------------------

When installed, the `load-initial-data.sh` script will be placed in `/etc/openhim/`
along with the data if you ever need to run it again.

After the package is installed the user must manually set the following:

* Nothing just yet...

When the config package is installed it will ask the user for the openhim server
address and for a username and password to use to import the config. To automate
this you may supply the value before installing the package. Eg.:

```sh
echo "openhim-config-mhero openhim-config/host string localhost" | debconf-set-selections
echo "openhim-config-mhero openhim-config/port string 8080" | debconf-set-selections
echo "openhim-config-mhero openhim-config/username string root@openhim.org" | debconf-set-selections
echo "openhim-config-mhero openhim-config/password password openhim-password" | debconf-set-selections
```

Building the package
--------------------

Execute `.create-deb.sh` to create the package. This script will ask you if you
want to upload to launchpad or just create a .deb file.
