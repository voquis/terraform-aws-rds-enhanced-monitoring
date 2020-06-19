RDS with Enhanced Monitoring
===

Terraform 0.12 module to create an RDS instance with enhanced monitoring.
Requires subnets in which to create a DB subnet group.
To customise DB engine, versions, etc. see defaults in variables.tf.

# Examples
## Minimal example
This example assumes you have a list of subnets available:
```terraform
provider "aws" {
  version = "2.65.0"
}

module "database" {
  source     = "voquis/rds-enhanced-monitoring/aws"
  version    = "0.0.1"
  subnet_ids = ["my-subnet-id-1", "my-subnet-id-2", "my-subnet-id-3"]
}
```

## Publicly accessible example
This example creates:
  - a VPC and subnets using [this module](https://github.com/voquis/terraform-aws-vpc-subnets-internet)
  - publicly accessible database (defaults to MySQL 8)
  - a security group to allow MySQL traffic from a fixed ip

```terraform
provider "aws" {
  version = "2.65.0"
}

# Create publicaly accessible RDS instance with defaults
module "database" {
  source                 = "voquis/rds-enhanced-monitoring/aws"
  version                = "0.0.1"
  publicly_accessible    = true
  subnet_ids             = module.networking.subnets[*].id
  vpc_security_group_ids = [aws_security_group.db.id]
}

# Create VPC and subnets
module "networking" {
  source           = "voquis/vpc-subnets-internet/aws"
  version          = "0.0.1"
  name             = "db"
  internet_gateway = true
  cidr_block       = "10.1.0.0/16"
  subnets = [
    {
      availability_zone       = "euw2-az1"
      cidr_block              = "10.1.0.0/24"
      map_public_ip_on_launch = true
      name                    = "db_subnet_1"
    },
    {
      availability_zone       = "euw2-az2"
      cidr_block              = "10.1.1.0/24"
      map_public_ip_on_launch = true
      name                    = "db_subnet_2"
    },
    {
      availability_zone       = "euw2-az3"
      cidr_block              = "10.1.2.0/24"
      map_public_ip_on_launch = true
      name                    = "db_subnet_3"
    }
  ]
}

# Create security group to allow inbound traffic from a single IP
resource "aws_security_group" "db" {
  vpc_id      = module.networking.vpc.id
  ingress {
    description = "MySQL from an IP"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["8.8.8.8/32"]
  }
}
```
