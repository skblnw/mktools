#!/bin/bash

if [[ "$#" -ne 0 ]]; then
    NAME="$1"
    check_node | grep $NAME | sort -u -k2,2 | awk '{print $2"\t"$4"\t"$5"\t"$6}'
    exit 0
fi

nodelist1=`seq 1 16`
nodelist2=`seq 0 6`

mkdir -p $HOME/tmp
mkdir -p $HOME/tmp/check_node

echo "Info: Creating node profiles..."
for ii in $nodelist1; do
    pbsnodes compute-0-$ii | grep "jobs =" | sed 's/.*jobs = //g' | tr ',' '\n' | tr '/' '\t' | awk -F '.' '{print $1}' > $HOME/tmp/check_node/node$ii
done

echo "Info: Done with node profiles"
echo "Info: Listing processes on nodes"
echo -e "Node name\t(free)"
echo -e "\t\t\tID\tCPU\tUser\tTotal\t[node_name:cpu_in_use]"
for ii in $nodelist1; do
    USED=`wc -l < $HOME/tmp/check_node/node$ii`
    FREE=$(expr 16 - $USED)
    echo ""
    echo -e "compute-0-${ii}\t($FREE)"
    cat $HOME/tmp/check_node/node$ii | awk '{print $2}' | sort -u > $HOME/tmp/check_node/TMP_ID
    for jobid in `cat $HOME/tmp/check_node/TMP_ID`; do
        echo -ne "|-\t\t\t${jobid}\t"
        echo -ne "`qstat -f $jobid | grep "ppn=" | tr '\n' ' ' | awk -F '+' '{print $1}' | sed 's/.*ppn=//g' | uniq`\t"
        echo -ne "`qstat -f $jobid | grep "Job_Owner = " | sed 's/.*Job_Owner = //g' | sed 's/@.*$//g' | cut -c1-7`\t"
        echo -ne "`checkjob $jobid | grep "Total Tasks" | awk '{print $3}'`\t"
        echo -ne "`checkjob $jobid | sed -n -e '/Allocated Nodes/,/IWD/p' | grep 'compute-0-' | sed 'N;s/\n//' | sed 's/compute-0-//g'`\t"
        echo ""
    done

    for ((jj=0; $jj<$USED; jj++)); do
        echo -ne "^"
    done
    for ((jj=0; $jj<$FREE; jj++)); do
        echo -ne "."
    done

    echo ""
done

for ii in $nodelist2; do
    pbsnodes compute-1-$ii | grep "jobs =" | sed 's/.*jobs = //g' | tr ',' '\n' | tr '/' '\t' | awk -F '.' '{print $1}' > $HOME/tmp/check_node/node$ii
done
for ii in $nodelist2; do
    USED=`wc -l < $HOME/tmp/check_node/node$ii`
    FREE=$(expr 48 - $USED)
    echo ""
    echo -e "compute-1-${ii}\t($FREE)"
    cat $HOME/tmp/check_node/node$ii | awk '{print $2}' | sort -u > $HOME/tmp/check_node/TMP_ID
    for jobid in `cat $HOME/tmp/check_node/TMP_ID`; do
        echo -ne "|-\t\t\t${jobid}\t"
        echo -ne "`qstat -f $jobid | grep "ppn=" | tr '\n' ' ' | awk -F '+' '{print $1}' | sed 's/.*ppn=//g' | uniq`\t"
        echo -ne "`qstat -f $jobid | grep "Job_Owner = " | sed 's/.*Job_Owner = //g' | sed 's/@.*$//g' | cut -c1-7`\t"
        echo -ne "`checkjob $jobid | grep "Total Tasks" | awk '{print $3}'`\t"
        echo -ne "`checkjob $jobid | sed -n -e '/Allocated Nodes/,/IWD/p' | grep 'compute-1-' | sed 'N;s/\n//' | sed 's/compute-1-//g'`\t"
        echo ""
    done

    for ((jj=0; $jj<$USED; jj++)); do
        echo -ne "^"
    done
    for ((jj=0; $jj<$FREE; jj++)); do
        echo -ne "."
    done

    echo ""
done
