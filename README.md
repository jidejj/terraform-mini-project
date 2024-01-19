# PROJECT

## USING TERRAFORM TO CREATE MULTIPLE INFRASTRUCTURE ON AWS

This project Using Terraform should achieve the following:
- Create several EC2 instances and put them behind an Elastic Load Balancer
- Ensure that after applying terraform plan, Terraform exports the public IP addresses of the instances to a file called host-inventory
- The domain that will be used in testing workability of the load balancer should be obtain (Get a .com.ng or any other domain name for yourself. Be creative, this will be a domain you can keep using)
- Set the domain up with AWS Route53 within your terraform plan
- Add an A record for subdomain terraform-test that points to your ELB IP address
- Create an Ansible script that uses the host-inventory file Terraform created to install Apache
- Set timezone to Africa/Lagos and displays a simple HTML page that displays content to clearly identify on all 3 EC2 instances.

## SOLUTION

Terraform files were created to handle different tasks as enumerated above. An ansible script was also created to manage the host-inventory and a yaml file was created to handle apache installation and timezone settings. 

#### Below is the output generated at the end of successful execution

### Outputs

- elb_load_balancer_dns_name = "inst-load-balancer-1472771923.eu-west-2.elb.amazonaws.com"
- vpc_id = "vpc-000f5378c60d0ce8b"
