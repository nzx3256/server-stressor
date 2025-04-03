#!/bin/bash

sudo cp $(pwd)/stress-sys.service /lib/systemd/system
chmod 744 stress-sys.sh
sudo chown root stress-sys.sh
sudo chgrp root stress-sys.sh
mkdir -p /opt/stress-app && cp display-stats.py stress-sys.sh plotlyapp.py -t /opt/stress-app

