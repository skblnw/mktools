#!/bin/bash
cd /home/kevin/welcome/tail_and_mail
if [ -s "/home/kevin/welcome/job-checking.txt" ]
then
  while read line;
  do
    if [ -s "$line" ]
    then
      echo -e "+---------------------------------------------------------------------------------------------+";
      echo -e "Tail(14) of \n $line \n says:";
      echo -e "+---------------------------------------------------------------------------------------------+";
      tail -14 $line;
      echo -e "\n";
      echo -e "+---------------------------------------------------------------------------------------------+";
      echo -e "Error(if any) appears in \n $line \n says:";
      echo -e "+---------------------------------------------------------------------------------------------+";
      grep -i error $line;
      echo -e "\n";
      echo -e "###############################################################################################";
      echo -e "\n";
    else
      echo -e "!!!Opps $line does not exist yet!!!\n"
    fi
  done < job-checking.txt > tail.txt

  mail -s "Auto: Job-checking" mcfc1301@gmail.com < /home/kevin/welcome/tail.txt
#  rm /home/kevin/welcome/tail.txt
  echo -e "`date`: Mail sent" >> mail.log
else
  echo -e "`date`: job-checking.txt is empty" >> mail.log
fi
