#!/bin/bash

if [ -z "$1" ]
then
   echo "failed, please input app param"
   exit 1
fi

INPUT_1="$1"

INPUT_1=${INPUT_1%.jar*}

APP_BASE=/app/$INPUT_1/
APP=${APP_BASE}${INPUT_1}.jar
LOG_DIR=${APP_BASE}log/

cd $APP_BASE

if ! [ -e $LOG_DIR ]; then
   mkdir -p $LOG_DIR
fi

if ! [ -e $APP ]; then
   echo "failed, $INPUT_1 not exit"
   exit
fi

PROC_ID=`ps axu | grep "java"|grep ${APP} |grep -v "grep"|awk '{print $2}'`

if [ -n "$PROC_ID" ]; then
   echo "$INPUT_1 pid ${PROC_ID} still running now , please shutdown it first!"
   exit 2
fi

PROP_CONFIG="${APP_BASE}conf/application"

if [ -e ${PROP_CONFIG}.properties ]; then
   PROP_CONFIG=file:${PROP_CONFIG}.properties
   nohup ${JAVA_HOME}/bin/java -jar -Xms256m -Xmx2048m -javaagent:/app/pinpoint/pinpoint-bootstrap-1.8.2.jar -Dpinpoint.agentId=${INPUT_1} -Dpinpoint.applicationName=${INPUT_1}  $APP --spring.config.location=${PROP_CONFIG} 1>> ${LOG_DIR}catalina.out 2>> ${LOG_DIR}catalina-error.out &
elif [ -e ${PROP_CONFIG}.yml ]; then
   PROP_CONFIG=file:${PROP_CONFIG}.yml
   nohup ${JAVA_HOME}/bin/java -jar -Xms256m -Xmx2048m -javaagent:/app/pinpoint/pinpoint-bootstrap-1.8.2.jar -Dpinpoint.agentId=${INPUT_1} -Dpinpoint.applicationName=${INPUT_1}  $APP --spring.config.location=${PROP_CONFIG} 1>> ${LOG_DIR}catalina.out 2>> ${LOG_DIR}catalina-error.out &
else
   PROP_CONFIG=
   nohup ${JAVA_HOME}/bin/java -jar -Xms256m -Xmx2048m $APP 1>> ${LOG_DIR}catalina.out 2>> ${LOG_DIR}catalina-error.out &
fi

cd -

if [ -n ${PROP_CONFIG} ]; then
   echo "warn!!!!, use propertis file : ${PROP_CONFIG}"
fi

if [ "$?" = "0" ]; then
    echo "$0 ${1%/} start succeed"
else
    echo "$0 ${1%/} start failed"
fi
#tail -f ${LOG_DIR}catalina.out
#tail -f ${LOG_DIR}catalina.out|sed '/Tomcat started on port/q'

tail -f ${LOG_DIR}catalina.out| sed '/.*Tomcat started on port.*/q'
