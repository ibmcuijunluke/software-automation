#!/bin/bash
PS=$(which ps)
GREP=$(which grep)
WHEN=$(date +"%Y-%m-%d-%H:%M:%S")
   if  ! $PS aux | $GREP "redis.conf" | $GREP -v grep 2>&1 > /dev/null; then
       /etc/init.d/redis restart
       echo 'Restarted Redis @' $WHEN
   fi
#Check Second instance
   if  ! $PS aux | $GREP "redis2.conf" | $GREP -v grep 2>&1 > /dev/null; then
       /etc/init.d/redis2 restart
       echo 'Restarted Redis2 @' $WHEN
   fi