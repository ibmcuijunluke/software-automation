#!/bin/bash

#echo " the WORKSPACE is --->"$WORKSPACE
#cd $WORKSPACE

hmswebwar=/opt/apache-tomcat-8.0.39/webapps/hms-web-1.0.0-SNAPSHOT.war
#hmswebwar=hms-web-1.0.0-SNAPSHOT.war
#rm -f hms-web-1.0.0-SNAPSHOT.war
echo "hmswebwar is =============="$hmswebwar
ls -ll

if [ -f "$hmswebwar" ]
then
    echo "$hmswebwar exists!"
    rm -f hms-web-1.0.0-SNAPSHOT.war
else
    echo "$hmswebwar not exists!"
fi


0001001Pwar=/opt/apache-tomcat-7-service/webapps/0001001P-1.0.0-SNAPSHOT.war
#ls -ll
#0001001Pwar=0001001P-1.0.0-SNAPSHOT.war
#rm -f 0001001P-1.0.0-SNAPSHOT.war
echo "0001001Pwar is======="$0001001Pwar

if [ -f "$0001001Pwar" ]
then
    echo "$0001001Pwar exists!"
    rm -f 0001001P-1.0.0-SNAPSHOT.war
else
    echo "$0001001Pwar not exists!"
fi

echo ""

cd /var/lib/jenkins/workspace/test-unittest-java
cd 0001001/0001001P/target/ 
#cd 0001001/0001001P/target/
ls -ll
chmod -R 777 *
cp 0001001P-1.0.0-SNAPSHOT.war /opt/apache-tomcat-7-service/webapps
ls -ll 0001001P-1.0.0-SNAPSHOT.war

cd /var/lib/jenkins/workspace/test-unittest-java
cd hms-web/target/
ls -ll
chmod -R 777 *
pwd
cp hms-web-1.0.0-SNAPSHOT.war /opt/apache-tomcat-7-controller/webapps
cd /opt/apache-tomcat-7-controller/webapps
ls -ll hms-web-1.0.0-SNAPSHOT.war



#cd 0002001/0002001P/target/
#ls -ll
#chmod -R 777 *

cd site
ls -ll

#clean surefire-report:report


