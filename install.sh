#!/bin/bash

sudo apt install python3-virtualenv -y
sudo apt install stress-ng -y
if [[ ! -d .venv ]]; then
	virtualenv .venv
fi
sudo cp stress-sys.service /lib/systemd/system
sudo cp stress_app /etc/cron.d
sudo chmod 744 stress-sys.sh
sudo chown root stress-sys.sh
sudo chgrp root stress-sys.sh
sudo chmod 744 restart-agent.sh
sudo chown root restart-agent.sh
sudo chgrp root restart-agent.sh
sudo /bin/bash -c 'mkdir -p /opt/stress-app && cp stress-sys.sh restart-agent.sh dashboard.py -t /opt/stress-app'
