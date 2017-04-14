#!/bin/bash
#author : cuijun 20161223
#pwd check code line statistics
#seldate=`date -d "1 weeks ago" +%Y-%m-%d`
seldate=`date +%Y-%m-%d`
echo " >>>the current date is ->$seldate"
cd cw-hms-web/
echo "#########>>>checkout to dev branch for web"
git checkout develop
git pull
echo "#########>>>checkout release1.0 branch for web"
git checkout release/1.0
git pull
echo "#########>>>staring merge web dev branch to rlease1.0 branch now....."
#git merge --no-ff release/1.0 &&
git merge --no-ff develop &&
git add .
git commit -am "@@@merge web dev to rlease1.0 branch"
sleep 1s
#git push origin develop
git push origin release/1.0
sleep 1s
git checkout develop
cd ..
echo "#########>>>merge web dev branch to release1.0 has been done."

echo "########################################################"
#source
cd cw-hms-source/
echo "#########>>>checkout to dev branch for source"
git checkout develop
git pull
echo " #########>>>checkout release1.0 branch for source"
git checkout release/1.0
git pull
echo " #########>>>staring merge source dev branch to rlease1.0 branch now....."
#git merge --no-ff release/1.0 &&
git merge --no-ff develop &&
git add .
git commit -am "@@@merge to rlease1.0 branch"
sleep 1s
#git push origin develop
git push origin release/1.0
sleep 1s
git checkout develop
cd ..
echo "#########>>>merge source dev branch to release1.0 has been done."
