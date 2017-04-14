##!/bin/bash
#author cuijun 2016-11-22 hpecuijun@hpe.com
#kill tomcat pid and copy new war deploy to target tomcat server and restart it.
#pidcontrlllist=`ps -ef|grep apache-tomcat-7-controller|grep -v "grep"|awk '{print $2}'`
warpackagedir=/opt/javawars
ngnixdir=/opt/ngnixstatic
#first pls set your tomcatdir and jenkins dir
tomcatdir=/opt/apache-tomcat-8.0.41
#jenkinsdir=/var/lib/jenkins/workspace/cw-hms-source
pidTomcatlist=`ps -ef|grep tomcat|grep -v "grep"|awk '{print $2}'`
echo "@@@@@@@@@@the tomcat process id is>>>>>>>>>>>>>$warpackagedir --->$pidTomcatlist"
#step 0 check dir and env settings 
if [ ! -d "$warpackagedir" ]; then  
    echo "$warpackagedir is not  exsit ,pls create it "
     exit 1
#mkdir -p "$warpackagedir"  
else
    echo "$warpackagedir is exsit"
fi  
if [ ! -f "$warpackagedir/jw-interfaceapi.war" ]; then
    echo "$warpackagedir is not exsit ,pls copy it to opt/javawars dir"
	exit 1
else
    echo "$warpackagedir/jw-interfaceapi.war is exsit"
fi
if [ ! -d "$ngnixdir" ]; then  
    echo "$ngnixdir is not exsit,pls create your ngnix zip static dir."
    exit 1
#mkdir -p "$ngnixdir"  
else
    echo "$ngnixdir is exsit"
fi  
#step 1
if [ "$pidTomcatlist" = "" ]
   then
       echo " the linux server has no tomcat pid alive!"
else
  echo "@@@@@@@@@@@tomcat Id list>>>>>>>>>>>>>>>> :$pidTomcatlist"
  kill -9 $pidTomcatlist
  #killall tomcat
  echo " the tomcat RA service stop success"
fi
#step 2 copy jenkins dir war to your /opt/javawar dir
#goto your jenkins build dir and copy newest buildwar to target dir
#cd $jenkinsdir
#ls -ll
#cd 3160001RA/target
#cp jw-interfaceapi.war $warpackagedir
#sleep 1s
#cd $warpackagedir
#chmod 777 *
#ls -ll
#step 3 delete all war and webapp file on your tomcatserver
echo "delete all wars for tomcat server...."
cd $tomcatdir
cd webapps
pwd
rm -rf jw-interfaceapi
rm -rf *.war
pwd
cp $warpackagedir/*.war .
chmod 777 jw-interfaceapi.war
#mv jw-interfaceapi.war $tomcatserverdir
#step 4 unzip zip file and restart ngnix service
cp $warpackagedir/*.zip $ngnixdir/
cd $ngnixdir
unzip -o -d $ngnixdir *.zip
#/usr/nginx/sbin/nginx -t
#/usr/local/nginx/sbin/nginx -s reload

#step 5 start your tomcat service
echo "starting tomcat service now........."
#cd /opt/apache-tomcat-7-controller/bin
#./startup.sh &
cd $tomcatdir/bin
ls -ll startup.sh
#nohup ./startup.sh &
nohup ./startup.sh &

echo " The all cw-source tomcat has been started."
exit 0
