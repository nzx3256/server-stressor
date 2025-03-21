#!/bin/bash

sudo systemctl disable stress-sys.service
sudo systemctl stop stress-sys.service
systemctl status stress-sys.service
