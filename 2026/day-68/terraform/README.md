## Lab Environment

- Creates four EC2 instances: **control-node**, **web-server**, **app-server**, and **db-server**
- All instances use the **t3.micro** type and Amazon Linux 2 AMIs
- Common security group allowing inbound port 22 (SSH)
- SSH access via an AWS key pair created from the `ansible.pub` public key file
- Outputs include each instance’s public IP, DNS, SSH user, and OS family

---

### Instance Details

| **Name** | **Instance Type** | **OS Family** | **SSH User** |
| --- | --- | --- | --- |
| control-node | t3.micro | amazon | ec2-user |
| web-server | t3.micro | amazon | ec2-user |
| app-server | t3.micro | amazon | ec2-user |
| db-server | t3.micro | amazon | ec2-user |

---

### How to Use

1. Make sure AWS credentials are configured (`aws configure` or environment variables).
2. Initialize Terraform: `terraform init`
3. Review the execution plan: `terraform plan`
4. Apply the plan to create resources: `terraform apply`
5. After deployment, retrieve instance details with: `terraform output instance_details`
6. To destroy all resources and avoid AWS charges: `terraform destroy`

### Note

- **Replace the AMI IDs** in `variables.tf` with ones valid for your AWS account and region.
- **Create your SSH key pair before applying**: generate an SSH key locally with `ssh-keygen` and place the public key file (`key_name.pub`) in the Terraform folder before running Terraform.
- **Do not include** public and private keys in your submission or public repos.