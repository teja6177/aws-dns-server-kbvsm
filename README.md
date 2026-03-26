# AWS DNS Server for kbvsm.com

## Overview
This repository automates:
1. Launching an EC2 instance
2. Installing Bind DNS
3. Deploying `kbvsm.com` zone
4. Adding A records dynamically

## Requirements
- Ansible >= 2.10
- Python `boto3` and `botocore`
- AWS account with IAM user keys

## How to run
```bash
export AWS_ACCESS_KEY_ID=YOUR_KEY
export AWS_SECRET_ACCESS_KEY=YOUR_SECRET
export AWS_DEFAULT_REGION=ap-south-1

ansible-galaxy collection install -r requirements.yml

ansible-playbook playbooks/launch_dns.yml
ansible-playbook playbooks/setup_dns.yml

# To add new records
ansible-playbook playbooks/add_record.yml
