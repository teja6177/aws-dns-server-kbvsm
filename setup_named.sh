#!/bin/bash
yum update -y
yum install -y bind bind-utils

# Enable and start named
systemctl enable named
systemctl start named
