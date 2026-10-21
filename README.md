# Terraform Lab — AWS Infrastructure as Code

Provision foundational AWS infrastructure with Terraform, storing state remotely in **S3** with **DynamoDB** state locking.

## Architecture

| Resource | Purpose |
|---|---|
| VPC | Isolated network for the lab |
| Public subnet | Hosts the EC2 instance |
| Internet Gateway + route | Gives the subnet internet access |
| Security group | SSH (22) from my IP, HTTP (80) from anywhere |
| EC2 (t2.micro) | Free Tier compute instance |
| S3 + DynamoDB | Remote state storage and locking |

## Project Structure

```
├── main.tf        # Provider and resources
├── variables.tf   # Input variables
├── outputs.tf     # Output values
└── screenshots/   # Verification screenshots
```

## Prerequisites

- Terraform >= 1.5
- AWS CLI configured (`aws configure`) with Free Tier / sandbox credentials

## Usage

```bash
terraform init
terraform plan
terraform apply
terraform destroy
```

---

## Build Log

### 1. VPC

Creates a VPC (`10.0.0.0/16` by default) with DNS support and DNS hostnames enabled, so instances launched inside it get resolvable public DNS names. Every resource is tagged with `Project` and `ManagedBy` via the provider's `default_tags`.

- **Variables:** `aws_region`, `project_name`, `vpc_cidr`
- **Outputs:** `vpc_id`, `vpc_cidr`

### 2. Public Subnet

Creates a `/24` subnet (`10.0.1.0/24` by default) inside the VPC, placed in the region's first available AZ (looked up dynamically, not hard-coded). `map_public_ip_on_launch` gives instances a public IP automatically. It becomes truly *public* once the Internet Gateway route is attached in the next step.

- **Variables:** `public_subnet_cidr`
- **Outputs:** `public_subnet_id`, `public_subnet_az`

### 3. Internet Gateway and Route

Attaches an Internet Gateway to the VPC and creates a public route table with a default route (`0.0.0.0/0`) pointing to it. The route table is associated with the public subnet, which is what actually makes the subnet public.

- **Outputs:** `internet_gateway_id`, `public_route_table_id`
