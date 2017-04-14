echo " the ProjectName is --->",${ProjectName}
#echo " the GitBranch is --->",${GitBranch}


echo "Strating Merge operate now ........................."
cd /opt/gitmerge-branch/
ls

if [ "$ProjectName" = "jw-source" ]; then
  echo "Good morning, $ProjectName will merge. Pls gogogo!! jw-source ."
  ./merge2releasejwSource.sh
  
elif [ "$ProjectName" = "cw-hms-source" ]; then
  echo "Good afternoon, $ProjectName will merge. Pls gogogo!!. cw-hms-source ."
  ./merge2releaseSource.sh
  
else
  echo "hello, $ProjectName will merge. Pls gogogo!!.cw-hms-web . "
  ./merge2releaseWeb.sh
  #exit 1
fi



#./pullNewCode.sh

#./merge2releaseWeb.sh

#./merge2releasejwSource.sh

#./merge2releaseSource.sh
exit 0