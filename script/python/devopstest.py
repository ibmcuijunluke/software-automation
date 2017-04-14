#!/usr/bin/python  
#-*-coding:UTF-8 -*-
'''
Created on 20170407
@author: cui.jun@thoughtworks.cn
'''
import sys,os,time
#from tw_devops import zipfileutils

print ("start deploy tomcat war and static zip package now .......");  

tomcatwebapphome="/opt/apache-tomcat-8.0.41/webapps" 
webappswar="/opt/apache-tomcat-8.0.41/webapps/jw-interfaceapi.war"
sourceunzip="/opt/apache-tomcat-8.0.41/webapps/jw-interfaceapi"  
targetjavawar="/opt/javawars";  
tomcathome="/opt/apache-tomcat-8.0.41" 
zipfiledirfile = '/opt/javawars/html5demo.zip'
warfiledirfile = '/opt/javawars/jw-interfaceapi.war'
ngnixTargetDir="/opt/ngnixdir"

current_date=time.strftime('%Y-%m-%d')  
current_datetime=time.strftime('%Y%m%d%H%M%S')  

#step 1
# print os.path.isfile(ngnix_zipfile_path)
#check our env ngnixzipfile and tomcatwar packages if exist
if os.path.isfile(zipfiledirfile): 
    message = 'OK, the "%s" file exists.',current_datetime
    pass
else:
    message = "Sorry, I cannot find the %s filee. ,pls create it"
    raise Exception("Sorry, I cannot find the  file. %s ")
    #sys.exit()
print "the message is ",message

if os.path.isfile(warfiledirfile): 
    message = 'OK, the "%s" file exists.',current_datetime
    pass
else:
    message = "Sorry, I cannot find the  %s file.  ,pls create it"
    raise Exception("Sorry, I cannot find the  s% file. %s ")
    #sys.exit()
print "the message is ",message


if os.path.isdir(ngnixTargetDir): 
    message = 'OK, the "%s"  ngnixfile dir exists.',current_datetime
    pass
else:
    message = "Sorry, I cannot find the  ngnixfile dir  ,pls create it ."
    raise Exception("Sorry, I cannot find the  ngnixfile dir. %s ")
    #sys.exit()
print "the message is ",message



#ngnixzipdir = 'html5-map.zip' 
# r = zipfilezipfileutilsfile(filename)
#step 2 unzip zip file to ngnix dir and restart ngnix
import zipfile
import os
#python2.7 zipfile libary has error, so i use python call shell.
#os.listdir(r'E:\\apache-tomcat-8.0.41\\webapps\\')
os.system("cp -f %s/html5demo.zip %s/" %(targetjavawar,ngnixTargetDir));
#os.system("cd %s" %(targetjavawar))
os.system("unzip -o -d  %s %s" %(ngnixTargetDir,zipfiledirfile))
#os.system("/usr/nginx/sbin/nginx -t")
#os.system("/usr/local/nginx/sbin/nginx -s reload")
#/usr/nginx/sbin/nginx -t
#/usr/local/nginx/sbin/nginx -s reload

#step 3 restart tomcat new war 
print "start application server......begin............."  
  
kill_cmd="kill `ps -ef | grep tomcat | awk '{print $2,$8}' | grep 'java$'| awk '{print $1}'`";  
os.system(kill_cmd);  
time.sleep(3);  
# os.system("rm -rf ");  
# time.sleep(3);  
os.system("rm -rf %s" %(webappswar));  
os.system("rm -rf %s" %(sourceunzip));

os.system("cp -rf %s %s/" %(targetjavawar,tomcatwebapphome));
# time.sleep(3);  
os.system("%s/bin/startup.sh &" %(tomcathome));  
#time.sleep(3);  
#Msg='-'*30+time.strftime('%Y-%m-%d %H:%M:%S')+'-'*30+'\n'  
#print " the time is ".Msg
#time.sleep(2); 
print "start application server......end............."  
