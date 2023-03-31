#!/bin/bash

terraform -chdir=/home/ubuntu/3tier/terraform/ apply -auto-approve
ansible-playbook -i /home/ubuntu/3tier/ansible/aws_rds.yaml -i /home/ubuntu/3tier/ansible/aws_ec2.yaml  /home/ubuntu/3tier/ansible/playbook --user ubuntu
