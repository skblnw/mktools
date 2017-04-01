#! /bin/bash
echo ''; echo 'checking GPU Usage...'; 
for i in compute-0-1 compute-0-2 compute-0-3 compute-0-4 compute-0-5 compute-0-6 compute-0-7 compute-0-8 compute-0-9 compute-0-10 compute-0-11 compute-0-12 compute-0-13 compute-0-14 compute-0-15 compute-0-16 ; 
do ssh -Y ${i} 'mem=$(nvidia-smi | grep 4799 | cut -d"/" -f3 | cut -d"|" -f2 | sed -e "s/^[ \t]*//"); 
if [[ "$mem" == 11MiB* ]]; 
then echo $(hostname) avalible; 
else  
echo $(hostname) $mem"being using"; 
fi'; 
done; 
echo ''; echo finish;
