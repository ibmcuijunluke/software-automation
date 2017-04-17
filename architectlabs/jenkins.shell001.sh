set -x

echo " the WORKSPACE is --->"$WORKSPACE
cd $WORKSPACE
javacontrlpath=/opt/apache-tomcat-7-controller/webapps
javaservicepath=/opt/apache-tomcat-7-service/webapps

ls -ll
#########################################################

cd $javaservicepath
jw001="0001001P-1.0.0-SNAPSHOT.war"
#rm -f 0001001P-1.0.0-SNAPSHOT.war
echo "============>$javaservicepath/$jw001"


if [ -f "$javaservicepath/$jw001" ]
then
    echo "$jw001 is exists!"
    rm -f 0001001P-1.0.0-SNAPSHOT.war

    #re-deploy war package to destin dir.
    sleep 1s
    cd $WORKSPACE/0001001/0001001P/target/
    ls -ll
    chmod -R 777 *
    cp $jw001 /opt/apache-tomcat-7-service/webapps
    cd $javaservicepath
    ls -ll $jw001

else
    echo "$jw001 not exists!"
    cd $WORKSPACE/0001001/0001001P/target/
    ls -ll
    chmod -R 777 *
    cp $jw001 /opt/apache-tomcat-7-service/webapps
    cd $javaservicepath
    ls -ll $jw001
fi

echo " --------------->check service has been done"

#######################################################

cd $javacontrlpath
hmswebwar="hms-web-1.0.0-SNAPSHOT.war"
#rm -f hms-web-1.0.0-SNAPSHOT.war
echo "============>$javacontrlpath/$hmswebwar"
ls -ll

if [ -f "$javacontrlpath/$hmswebwar" ]
then
    echo "$hmswebwar is exists!"
    rm -f hms-web-1.0.0-SNAPSHOT.war

    #re-deploy war package to destin dir.
    sleep 1s
    cd $WORKSPACE/hms-web/target
    ls -ll
    chmod -R 777 *

    cp $hmswebwar /opt/apache-tomcat-7-controller/webapps
    cd $javacontrlpath
    ls -ll $hmswebwar

else
    echo "$hmswebwar not exists!"
    cd $WORKSPACE/hms-web/target
    ls -ll
    chmod -R 777 *

    cp $hmswebwar /opt/apache-tomcat-7-controller/webapps
    cd $javacontrlpath
    ls -ll $hmswebwar
fi

echo " --------------->check all tomcat package has been done"
#cd 0002001/0002001P/target/
#ls -ll
#chmod -R 777 *
#cd site
#ls -ll
#clean surefire-report:report

cd /opt/
ls -ll restartTomcat.sh
whoami
./restartTomcat.sh
