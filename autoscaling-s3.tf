variable "key_name" {
  type        = string
}
variable "InstanceType" {
  type        = string
}
variable "GitUser" {
  type        = string
}
variable "GitEmail" {
  type        = string
}
variable "GitPassword" {
  type        = string
}
variable "S3BucketKeyID" {
  type        = string
}
variable "S3BucketAccessKey" {
  type        = string
}
variable "S3BucketRegion" {
  type        = string
}

data "template_file" "user_data" {
  template = file("cloudinit.yml")
    vars = {
    GitUser = var.GitUser
    GitEmail = var.GitEmail
    GitPassword = var.GitPassword
    DBName = aws_db_instance.DBInstance.name
    DBUser = aws_db_instance.DBInstance.username
    DBPassword = var.DBPassword
    DBInstanceEndpointAddress = aws_db_instance.DBInstance.address
    S3BucketKeyID = var.S3BucketKeyID
    S3BucketAccessKey = var.S3BucketAccessKey
    S3BucketRegion = var.S3BucketRegion
    S3BucketName = aws_s3_bucket.S3Bucket.id
  }
}

resource "aws_launch_configuration" "LaunchConfig" {
    name = "LaunchConfig"
    image_id = "ami-0ce107ae7af2e92b5"
    instance_type = var.InstanceType
    key_name = var.key_name
    security_groups = [aws_security_group.ASSecurityGroup.id]
    root_block_device {
        volume_type = "gp2"
        volume_size = 8
        delete_on_termination = true
    }
    user_data = data.template_file.user_data.rendered
}

resource "aws_autoscaling_group" "WEBServerGroup" {
    name = "WEBServerGroup"
    vpc_zone_identifier = [
        aws_subnet.SubnetsPUB1.id,
        aws_subnet.SubnetsPUB2.id,
    ]
    launch_configuration = aws_launch_configuration.LaunchConfig.id
    min_size = 1
    max_size = 5
    desired_capacity = 2
    target_group_arns = [aws_lb_target_group.ALBTargetGroup.arn]
}
