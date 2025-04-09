#!/bin/bash
# check if stress-sys.sh is running and if not, restart it.

target="/opt/stress-app/stress-sys.sh"
if [[ ! -f $target ]]; then
	exit 1
fi

daem_status=$(systemctl is-active stress-sys.service)
if [[ $daem_status = "inactive" ]]; then
	sudo systemctl start stress-sys.service
fi
