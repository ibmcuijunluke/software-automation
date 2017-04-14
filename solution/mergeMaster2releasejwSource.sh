#!/bin/bash
#author : cuijun 20161223
#pwd check code line statistics
#seldate=`date -d "1 weeks ago" +%Y-%m-%d`
seldate=`date +%Y-%m-%d`
#devbranchname=develop
devbranchname=master
rel1branchname=release/1.0
echo " >>>the current date is ->$seldate jw-source"
echo " >>>>jw-source the rel1branchname is ->$rel1branchname,>>>> the devbranchname is ->$devbranchname"
cd jw-source/
echo "#########>>>checkout to dev branch for source jw-source"
git checkout $devbranchname
git pull
echo "#########>>>checkout release1.0 branch for source jw-source"
git checkout $rel1branchname
git pull
echo "#########>>>staring merge jw-source dev branch to rlease1.0 branch now....."
#git merge --no-ff release/1.0 &&
git merge --no-ff $devbranchname &&
git add .
git commit -am "@@@merge jw-source dev to rlease1.0 branch"
sleep 1s
#git push origin develop
git push origin $rel1branchname
sleep 1s
git checkout $devbranchname
cd ..
echo "#########>>>merge jw-source dev branch to release1.0 has been done."


