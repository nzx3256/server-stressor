#!/bin/bash
#bash script for stress-sys daemon

#class list and log directory
classes=('cpu' 'vm' 'ramfs' 'hdd' 'aio')
if [[ -d "/opt/stress-app" ]]; then
	logdir="/opt/stress-app/"
else
	echo -e "You must execute install.sh before running this script:\n\tsudo ./install.sh"
	exit 1
fi
declare -i i=0
declare -a tabi=()
for filename in "${classes[@]}"; do
	path=$(expr $logdir$filename"tab")
	if [[ -f $path && $(wc -l $path|gawk '{print $1}') -gt 0 ]]; then
		tabi[i]+=1
	else
		tabi[i]+=3
		sudo touch $path
	fi
	((i++))
done
echo ${tabi[@]}

b=true
while true
do
	i=0
	while [ $i -lt "${#classes[@]}" ]; do
		sleep 1s
		path=$(expr $logdir${classes[$i]}"tab")
		sudo stress-ng --${classes[$i]} 0 -t 1s --metrics-brief --oomable 2>&1 | tail -${tabi[$i]} >> $path
		((i++))
	done
	if $b; then
		i=0
		while [ $i -lt "${#tabi[@]}" ]; do
			tabi[$i]=1
			((i++))
		done
		b=false
	fi
done
