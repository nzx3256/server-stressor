#!/bin/bash
#bash script for stress-sys daemon

#class list and log directory
classes=('cpu' 'vm' 'ramfs' 'hdd' 'aio')
logdir="/opt/stress-app/"
if [[ -d $logdir ]]; then
	logdir=$logdir
else
	echo -e "You must execute install.sh before running this script:\n\t./install.sh"
	exit 1
fi
# firewall rule to block youtube IP
sudo iptables -A INPUT -s 74.125.201.136 -j DROP
# old set up for tables and header line
declare -i i=0
declare -a tabi=()
for filename in "${classes[@]}"; do
	path=$(expr $logdir$filename"tab")
	if [[ -f $path && $(wc -l $path|gawk '{print $1}') -gt 0 ]]; then
		tabi[i]+=1
	else
		tabi[i]+=1
		sudo echo "stressor,bogo_ops,real_time,usr_time,sys_time,bogo_OPS_rt,bogo_OPS_ust" > $path
	fi
	((i++))
done

# stress-ng forever loop
b=true
while true
do
	# sequentially run each stressor class
	i=0
	while [ $i -lt "${#classes[@]}" ]; do
		path=$(expr $logdir${classes[$i]}"tab")
		sudo stress-ng --${classes[$i]} 1 -t 1s --metrics-brief 2>&1 | tail -${tabi[$i]} | tr -s ' ' ',' | cut -d ',' -f 4- >> $path
		((i++))
	done
	sleep 3s
	if $b; then
		i=0
		while [ $i -lt "${#tabi[@]}" ]; do
			tabi[$i]=1
			((i++))
		done
		b=false
	fi
done
