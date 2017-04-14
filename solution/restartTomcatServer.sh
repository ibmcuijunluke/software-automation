#!/bin/bash
#author cuijun 2016-11-22
#kill tomcat pid
pidtomcatpid=`ps -ef|grep apache-tomcat-7-service|grep -v "grep"|awk '{print $2}'`
echo "the tomcat process is --->$pidtomcatpid"

if [ "$pidtomcatpid" = "" ]
   then
       echo "no tomcat pid alive!"
else
  echo "tomcat Id list :$pidtomcatpid"
  kill -9 $pidtomcatpid
  #killall tomcat
  echo "service stop success"
fi

echo "starting backend tomcat services............."

cd /opt/apache-tomcat-7-controller/bin
./startup.sh &

echo " the backend tomcat has been started."
