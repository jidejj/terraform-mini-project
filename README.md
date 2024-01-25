# Project Title: Terraform and Ansible Infrastructure Automation
## Overview
This project automates the deployment of a highly available and scalable web infrastructure on AWS using Terraform and Ansible. The infrastructure consists of two EC2 instances placed behind an Elastic Load Balancer (ELB). The public IP addresses of the instances are exported to a file called host-inventory. Additionally, a custom domain (terraform-test.yoursdmain.com) is obtained and configured using AWS Route 53, with an A record pointing to the ELB IP address. An Ansible script is then created to install Apache, set the timezone to Africa/Lagos, and display a simple HTML page on the two EC2 instances.

## Prerequisites
Before running the Terraform and Ansible scripts, ensure that you have the following prerequisites:

- AWS CLI installed and configured with the necessary credentials.
- Terraform installed on your local machine.
- Ansible installed on your local machine.
- A registered domain name for your project.

## Project Structure

### terraform/
- main.tf: Main Terraform configuration.
- variables.tf: Variable declarations.
- outputs.tf: Exported outputs.
- ec2.tf: EC2 instance configurations.
- elb.tf: Elastic Load Balancer configuration.
- route53.tf: AWS Route 53 configuration.
- sg.tf: Security Group configuration.

### ansible-playbook/
- ansible.cfg: Ansible configuration file.
- site.yaml: Ansible playbook defining tasks and handlers.

### README.md: Documentation for the project

## Ansible Configuration
The Ansible configuration is specified in the following files:

ansible.cfg: Ansible configuration settings.

## Ansible Playbook
The Ansible playbook is defined in site.yaml and includes the following tasks:

- Update and upgrade the servers.
- Set the timezone to Africa/Lagos.
- Install Apache2.
- Remove the default index.html.
- Use the printf script to generate custom content.
- Restart Apache service.

## Instructions
1. Clone this repository to your local machine by executing the following command in your command-line:
git clone https://github.com/jidejj/terraform-mini-project.git

2. Navigate to the project directory:
cd terraform-mini-project

3. Update the necessary configuration files:
Update variables.tf with your AWS credentials and desired configurations.
Update ansible.cfg with the correct private_key_file path.
Customize the content of the site.yaml playbook if needed.

4. Run Terraform to deploy the infrastructure:
- cd terraform
- terraform init
- terraform apply

This will create the EC2 instances, ELB, and export public IP addresses to host-inventory.

5. Run Terraform again to obtain the ELB DNS name:
terraform apply
Note the ELB DNS name from the output.

6. Update the main.tf file in the terraform directory with the ELB DNS name for the domain_name variable.

7. Run Terraform to update Route 53 with the custom domain:
terraform apply

8. Visit terraform-test.yoursdmain.com in a web browser to see the rotating content from the EC2 instances.

## Clean Up
To destroy the infrastructure and clean up resources, run:
cd ../terraform
terraform destroy
Confirm with 'yes' when prompted.

## Contributors
Your Name your.email@example.com

### Outputs
Your output should look something like:

- elb_load_balancer_dns_name = "inst-load-balancer-1472771923.eu-west-2.elb.amazonaws.com"
- vpc_id = "vpc-000f5378c60d0ce8b"
