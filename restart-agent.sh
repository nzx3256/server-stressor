#!/bin/bash
# check if stress-sys.sh is running and if not, restart it.

# verify installation
target="/opt/stress-app/stress-sys.sh"
if [[ ! -f $target ]]; then
	exit 1
fi

# restart daemon every 5 minutes if inactive
daem_status=$(systemctl is-active stress-sys.service)
if [[ $daem_status = "inactive" ]]; then
	sudo systemctl start stress-sys.service
fi
