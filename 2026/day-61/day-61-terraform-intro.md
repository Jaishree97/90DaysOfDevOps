# Day 61 -- Introduction to Terraform and Your First AWS Infrastructure

## Task 1: Understand Infrastructure as Code
Before touching the terminal, research and write short notes on:

1. What is Infrastructure as Code (IaC)? Why does it matter in DevOps?

- My answer: IaC means managing infrastructure through code instead of manually creating resources through the cloud console.

2. What problems does IaC solve compared to manually creating resources in the AWS console?

- My answer: It reduces manual work, makes infrastructure repeatable and consistent, and allows infrastructure configuration to be version-controlled.

3. How is Terraform different from AWS CloudFormation, Ansible, and Pulumi?

- My answer: Terraform and CloudFormation are mainly used for infrastructure provisioning. Ansible is mainly used for configuration management, while Pulumi also manages infrastructure but uses general-purpose programming languages.

4. What does it mean that Terraform is "declarative" and "cloud-agnostic"?

- My answer: Declarative means defining the desired infrastructure state rather than writing every step to create it. Cloud-agnostic means Terraform can work with multiple cloud and service providers.