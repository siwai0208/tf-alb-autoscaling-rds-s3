# **ALB & RDS & Autoscaling & S3 by Terraform**

## **About**

Make New EC2 AutoScaling with following packages
- mysql-client
- nginx
- php7.3
- [sample-laravel-app-s3](https://github.com/siwai0208/food-app-s3)

## **How to Use**

**1. Make .tfvars file from sample**

    mv terraform.tfvars.sample terraform.tfvars

**2. Set following parameter in terraform.tfvars**

- aws_access_key
- aws_secret_key
- aws_region (default: ap-northeast-1)
- VPCCIDR (default: 10.0.16.0/20)
- SubnetsPUB1CIDR (default: 10.0.16.0/24)
- SubnetsPUB2CIDR (default: 10.0.17.0/24)
- SubnetsPRV1CIDR (default: 10.0.24.0/24)
- SubnetsPRV2CIDR (default: 10.0.25.0/24)
- SSHLocation
- HTTPLocation
- key_name
- InstanceType (default: t2.micro)
- GitUser
- GitEmail
- GitPassword
- DBUser
- DBPassword
- DBName
- DBAz (default: ap-northeast-1a)
- DBSourceIP (default: 10.0.16.0/23)
- S3BucketKeyID
- S3BucketAccessKey
- S3BucketRegion (default: ap-northeast-1a)
- S3BucketName

**3. Run commands using the terraform**

    $ terraform init
    ...
    $ terraform apply
    ...
    Apply complete!