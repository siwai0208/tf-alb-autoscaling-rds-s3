variable "DBName" {
  type        = string
}
variable "DBUser" {
  type        = string
}
variable "DBPassword" {
  type        = string
}
variable "DBAz" {
  type        = string
}
variable "DBSourceIP" {
  type        = string
}

resource "aws_security_group" "DBSecurityGroup" {
    vpc_id= aws_vpc.VPC.id
    ingress{
        from_port = 3306
        to_port   = 3306
        protocol  = "tcp"
        cidr_blocks = [var.DBSourceIP]
    }
    egress{
       from_port  = 0
       to_port    = 0
       protocol   = "-1"
       cidr_blocks = ["0.0.0.0/0"]
   }
}

resource "aws_db_subnet_group" "DBSubnetGroup" {
    name       = "rds-subnets"
    description = "-"
    subnet_ids = [
        aws_subnet.SubnetsPRV1.id,
        aws_subnet.SubnetsPRV2.id,
    ]
}

resource "aws_db_instance" "DBInstance" {
    allocated_storage  = 20
    storage_type  = "gp2"
    engine  = "mysql"
    engine_version  = "5.7.31"
    instance_class = "db.t2.micro"
    name = var.DBName
    username = var.DBUser
    password = var.DBPassword
    availability_zone = var.DBAz
    skip_final_snapshot = "true"
    db_subnet_group_name = aws_db_subnet_group.DBSubnetGroup.id
    vpc_security_group_ids = [aws_security_group.DBSecurityGroup.id]
}