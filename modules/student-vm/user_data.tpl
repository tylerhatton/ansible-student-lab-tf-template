#!/bin/bash

## Installing Packages
sudo apt-get update
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible -y