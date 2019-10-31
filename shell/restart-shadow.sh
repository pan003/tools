#!/bin/bash
python /usr/local/shadowsocks/server.py -c /etc/shadowsocks-r/config.json -d stop
sleep 5
python /usr/local/shadowsocks/server.py -c /etc/shadowsocks-r/config.json -d start
