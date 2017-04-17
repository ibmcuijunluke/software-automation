pwd
ls -ll

#install and excute some cnpm and npm
#cnpm i
ls -ll
#sleep 1m

#npm run dev
#ls -ll
echo "===========WORKSPACE is $WORKSPACE"

#cnpm i express --save-dev #start webserver
#cnpm i serve-favicon path morgan cookie-parser body-parser --save-dev #start webserver
#cnpm i html serve-favicon --save-dev
#cd /opt/apache-nodejs-web
#rm -rf *
chmod 777 $WORKSPACE/*
cp -rf $WORKSPACE/* /opt/apache-nodejs-web/
#sleep 10
#cd /usr/local/nginx/sbin
#./ngnix -s reload
#chmod 777 serverweb.sh
#nodeID=$(ps -ef |grep node | awk '{ print $2 }')
#sleep 5
#echo "==============>$nodeID"
#./serverweb.sh &

#if [ "$nodeID" == "" ]; then
#  echo "starting babel process........."
  #BUILD_ID=dontKillMe
#  echo "有进程........"
#  kill -9 $nodeID

#else
#  echo "没有进程........"
#  babel-node server.js
  #kill -9 $nodeID
#fi



echo "the node webjs has been done.!"
#excute node js backend process
#OLD_BUILD_ID=$BUILD_ID
#echo " the OLD_BUILD_ID ==========>"$OLD_BUILD_ID
#BUILD_ID=dontKillMe

#nohup babel-node server.js &
#改回原来的BUILD_ID值
#BUILD_ID=$OLD_BUILD_ID
#echo " the OLD_BUILD_ID ==========>" $BUILD_ID

#BUILD_ID=dontKillMe
#nohup
