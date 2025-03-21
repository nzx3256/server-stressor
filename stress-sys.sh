#!/bin/bash

if [ -e /home/jordan_castelino/cloud-project/cputab ]; then
	cat /dev/null > /home/jordan_castelino/cloud-project/cputab
else
	touch /home/jordan_castelino/cloud-project/cputab
fi
if [ -e /home/jordan_castelino/cloud-project/vmtab ]; then
	cat /dev/null > /home/jordan_castelino/cloud-project/vmtab
else
	touch /home/jordan_castelino/cloud-project/vmtab
fi
if [ -e /home/jordan_castelino/cloud-project/ramfstab ]; then
	cat /dev/null > /home/jordan_castelino/cloud-project/ramfstab
else
	touch /home/jordan_castelino/cloud-project/ramfstab
fi
if [ -e /home/jordan_castelino/cloud-project/hddtab ]; then
	cat /dev/null > /home/jordan_castelino/cloud-project/hddtab
else
	touch /home/jordan_castelino/cloud-project/hddtab
fi
if [ -e /home/jordan_castelino/cloud-project/aiotab ]; then
	cat /dev/null > /home/jordan_castelino/cloud-project/aiotab
else
	touch /home/jordan_castelino/cloud-project/aiotab
fi

i=3
while true
do
	sudo stress-ng --cpu 0 --cpu-load 50 -t 10s --metrics-brief 2>&1 | tail -$i >> /home/jordan_castelino/cloud-project/cputab
	sleep 1s
	sudo stress-ng --vm 0 --vm-bytes 25% -t 10s --metrics-brief 2>&1 | tail -$i >> /home/jordan_castelino/cloud-project/vmtab
	sleep 1s
	sudo stress-ng --ramfs 0 -t 10s --metrics-brief 2>&1 | tail -$i >> /home/jordan_castelino/cloud-project/ramfstab
	sleep 1s
	sudo stress-ng --hdd 0 --hdd-opts direct,sync,dsync,fsync,utimes -t 10s --metrics-brief 2>&1 | tail -$i >> /home/jordan_castelino/cloud-project/hddtab
	sleep 1s
	sudo stress-ng --aio 0 --aio-requests 128 -t 10s --metrics-brief 2>&1 | tail -$i >> /home/jordan_castelino/cloud-project/aiotab
	sleep 10s
	i=1
done
