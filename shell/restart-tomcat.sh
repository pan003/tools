#!/usr/bin/env bash
APP_DOMAIN=*.jd.local
APP_WAR=jd-*.war

source /etc/profile
/export/Domains/$APP_DOMAIN/server1/bin/stop.sh
sleep 5
rm -rf /export/App/$APP_DOMAIN/*
cp /tmp/$APP_WAR /export/App/$APP_DOMAIN/
cd /export/App/$APP_DOMAIN/
jar -xvf /export/App/$APP_DOMAIN/$APP_WAR
/export/Domains/$APP_DOMAIN/server1/bin/start.sh
