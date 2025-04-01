#!/bin/bash

if [ -e /home/jordan_castelino/cloud-project/cputab ]; then
	i=1
else
	i=3
	touch /home/jordan_castelino/cloud-project/cputab
fi
if [ -e /home/jordan_castelino/cloud-project/vmtab ]; then
	i=1
else
	i=3
	touch /home/jordan_castelino/cloud-project/vmtab
fi
if [ -e /home/jordan_castelino/cloud-project/ramfstab ]; then
	i=1
else
	i=3
	touch /home/jordan_castelino/cloud-project/ramfstab
fi
if [ -e /home/jordan_castelino/cloud-project/hddtab ]; then
	i=1
else
	i=3
	touch /home/jordan_castelino/cloud-project/hddtab
fi
if [ -e /home/jordan_castelino/cloud-project/aiotab ]; then
	i=1
else
	i=3
	touch /home/jordan_castelino/cloud-project/aiotab
fi

while true
do
	sleep 1s
	sudo stress-ng --cpu 0 --cpu-load 50 -t 5s --metrics-brief 2>&1 | tail -$i >> /home/jordan_castelino/cloud-project/cputab
	sleep 1s
	sudo stress-ng --vm 0 --vm-bytes 25% -t 5s --metrics-brief 2>&1 | tail -$i >> /home/jordan_castelino/cloud-project/vmtab
	sleep 1s
	sudo stress-ng --ramfs 0 -t 5s --metrics-brief 2>&1 | tail -$i >> /home/jordan_castelino/cloud-project/ramfstab
	sleep 1s
	sudo stress-ng --hdd 0 --hdd-opts direct,sync,dsync,fsync,utimes -t 5s --metrics-brief 2>&1 | tail -$i >> /home/jordan_castelino/cloud-project/hddtab
	sleep 1s
	sudo stress-ng --aio 0 --aio-requests 128 -t 5s --metrics-brief 2>&1 | tail -$i >> /home/jordan_castelino/cloud-project/aiotab
	i=1
done
