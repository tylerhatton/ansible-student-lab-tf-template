# Ansible Student Lab Terraform Template

A basic templatized Ubuntu VM with Ansible installed to facilitate on-demand Ansible classes on www.wwt.com

![Lab Picture](/images/1.png)

## Getting Started

1. Register an account at https://www.wwt.com/register
2. Navigate to https://www.wwt.com/lab/ansible-student-vm and click the **Launch Lab** button.
3. Click the **View Labs** button in the bottom right and click **Access Lab** to open up the lab interface.

## Modules

This template is comprised of two Terraform modules.
- **modules/vpc** - Creates the underlying VPC and subnets that will host the student VM.
- **modules/student-vm** - Creates the student lab VM with bootstrap commands stored in user_data.tlp