#!/bin/sh
sed -i "s/<ACM_USER>/$ACM_USER/" acmanager/settings.js
sed -i "s/<ACM_PASS>/$ACM_PASS/" acmanager/settings.js
cp -r /tmp/content/* /home/steam/assetto/content/
cp -r /tmp/content/* /home/steam/assetto/content/