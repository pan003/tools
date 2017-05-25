#!/usr/bin/env bash
######cp war########
scp -r /source.war user@host:/tmp/
######restart app####
ssh user@host "sh ~/restart-tomcat.sh"
