#!/bin/bash

sudo systemctl enable stress-sys.service
sudo systemctl start stress-sys.service
systemctl status stress-sys.service
