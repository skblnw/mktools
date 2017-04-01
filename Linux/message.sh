#!/bin/bash

##########################################################################################
# Check whether the "awk", "sed", and "egrep" are supported by your system.
errormesg=""
programs="awk sed egrep ps cat cut tee netstat df uptime"
for profile in $programs
do
which $profile > /dev/null 2>&1
if [ "$?" != "0" ]; then
echo -e "Your system does not have $profile "
errormesg="yes"
fi
done
if [ "$errormesg" == "yes" ]; then
echo "Your system did not support the commands that this script required, $0 stopped!"
exit 1
fi

##########################################################################################
# 0.1 version information，and related log files!
# 23 Jun 2014
UPtime=`uptime | awk '{print $3" "$4}' | sed 's/,//g'`
export UPtime

TODAY=`date +%b' '%e`
export TODAY

YESTERDAY=`date --date="yesterday" +%b' '%e`
export YESTERDAY

USER=`whoami`
export USER

##########################################################################################
# 0.2 version
# 22 Jan 2015
# Updated queuing system and corresponding Job monitoring logs


echo -e "
           ___           ___           ___           ___           ___     
          /\  \         /\  \         /\__\         /\  \         /\  \    
         /::\  \       /::\  \       /::|  |       /::\  \       /::\  \   
        /:/\:\  \     /:/\:\  \     /:|:|  |      /:/\:\  \     /:/\:\  \  
       /:/  \:\  \   /:/  \:\  \   /:/|:|__|__   /::\~\:\__\   /:/  \:\  \ 
      /:/__/ \:\__\ /:/__/ \:\__\ /:/ |::::\__\ /:/\:\ \:|__| /:/__/ \:\__\\
      \:\  \  \/__/ \:\  \ /:/  / \/__/~~/:/  / \:\~\:\/:/  / \:\  \ /:/  /
       \:\  \        \:\  /:/  /        /:/  /   \:\ \::/  /   \:\  /:/  / 
        \:\  \        \:\/:/  /        /:/  /     \:\/:/  /     \:\/:/  /  
         \:\__\        \::/  /        /:/  /       \::/__/       \::/  /   
          \/__/         \/__/         \/__/         ~~            \/__/    

#############################################################################
#                            Welcome to COMBO!                              #
#              You are acessing through kevin@ourphysics.org                #
#              This is a beta welcoming script of version 0.2               #
#                   And was last updated on 22 Jan 2015                     #
#############################################################################

It's `date +%d' '%B' '%Y' '%H:%M:%S' '\(' '%A' '\)`
Combo has been already up for `echo $UPtime`
Among the last 100 refused logins, <`cat /var/log/secure | grep "refused" | tail -100 | sed 's/^.*from//g' | sed 's/(.*)//g' | uniq -c | sort | tail -1 | awk '{print $2}'`> is trending with `cat /var/log/secure | grep "refused" | tail -100 | sed 's/^.*from//g' | sed 's/(.*)//g' | uniq -c | sort | tail -1 | awk '{print $1}'` times!

Hostname: `hostname`
Username: `whoami`
Jobs: 
  CPU:
    `qstat | grep "$USER" | grep "Q" | wc -l` job(s) queuing
    `qstat | grep "$USER" | grep "R" | wc -l` job(s) running, out of
`showq | grep of`
  GPU:
    `gostat | grep "$USER" | grep "Q" | wc -l` job(s) queuing
    `gostat | grep "$USER" | grep "R" | wc -l` job(s) running, out of
  `gostat | tail -1`

Today's login records:
#############################################################################
`last -a | grep -v "wtmp" | grep -v "matlab" | grep $(date +%b) | sort -k1,1 -rk5,5 | sort -uk1,1 `
#############################################################################

Sysyem paritions:
#############################################################################
`df -h | egrep --color=never "Size|/$|/export|/data" | sed 's/^/\t/g'`
#############################################################################
Home: `du /home/$USER -sh`
Data: `du /share/data/$USER -sh`
Dat2: `du /share/data2/$USER -sh`

"

#Sessions: `who | grep $USER | wc -l` of `who | wc -l`
#Processes: `ps u | wc -l` of `ps au | grep -v "root" | wc -l`

#Kernel version: `uname -r`
#CPU info: `cat /proc/cpuinfo | grep "model name" | uniq | sed 's/model name\t://g'`

#The most recent 100 logins:
#############################################################################
#`last -100 | grep -v "system" | cut -d ' ' -f1 | head -n -2 | sort | uniq -c | sort | sed 's/^    /\t/g'`
#############################################################################

#The last 5 refused access:
#############################################################################
#`cat /var/log/secure | grep "refused" | tail -5 | sed 's/combo.*://g' | sed 's/port.*$//g'`
#############################################################################

#Login records
#############################################################################
#`cat /var/log/secure | grep "Accept" | grep -v "kevin" | egrep "$TODAY|$YESTERDAY" | grep -v "hostbased" | sed 's/combo.*:.*Accepted//g' | sed 's/port.*$//g' | sort -u -k6`
#############################################################################
