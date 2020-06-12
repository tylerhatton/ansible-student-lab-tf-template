#!/bin/bash

## Installing Packages
sudo apt-get update
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible -y

# Setting default password and SSH Auth
sudo echo -e "${password}\n${password}" | passwd ubuntu
sudo sed -i "s/.*PasswordAuthentication.*/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sudo systemctl restart sshd

## Setting up MOTD
sudo chmod -x /etc/update-motd.d/*

echo "Configuring MOTD"
sudo cat << 'EOF' > /etc/update-motd.d/01-warning
#!/usr/bin/env bash
echo "Use of this system is governed by WWT's Information Security and Privacy policies which include, but are not limited to:
--- Authorized and Acceptable Use Only: You must be authorized by WWT to access this system. Unauthorized, illegal, or
inappropriate use of the system is prohibited and may be subject to criminal and civil penalties.
--- Privacy and Monitoring: Use of this system indicates your acknowledgement and consent to WWT monitoring, recording,
and auditing your use of WWT managed systems and to the WWT Privacy Policy set forth at https://www2.wwt.com/privacy-policy/.
--- Suspension of Service: WWT reserves the right to suspend your access to WWT resources at any time without notice.
--- Circumventing Security Measures: You agree not to attempt to circumvent any security measures.
--- Confidential Data: You acknowledge that you may have access to non-public data within this system and agree that you will not share that data with any third parties."
EOF

echo "Configuring MOTD"
sudo cat << 'EOF' > /etc/update-motd.d/02-ipaddress
#!/usr/bin/env bash
echo ""
echo "===Student VM Public IP==="
curl http://169.254.169.254/latest/meta-data/public-ipv4
echo ""
echo ""
EOF

sudo chmod 755 /etc/update-motd.d/01-warning
sudo chmod 755 /etc/update-motd.d/02-ipaddress