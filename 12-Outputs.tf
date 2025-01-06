#Outputs
output "images_bucket_name" {
  value = aws_s3_bucket.images_bucket.bucket
}

output "logs_bucket_name" {
  value = aws_s3_bucket.logs_bucket.bucket
}

output "logs_access_role_name" {
  value = aws_iam_role.ec2_write_to_logs.name
}

output "vpc_id" {
  description = "ID of project VPC"
  value       = aws_vpc.poc-vpc-cf.id
}

output "name_prefix" {
  description = "Name prefix for the app"
  value       = var.name_prefix
}

output "instance_ami" {
  description = "AMI ID for the instance"
  value       = var.instance_ami
}

output "load_balancer_dns_name" {
  description = "The DNS name of the load balancer"
  value       = "http://${aws_lb.app_lb.dns_name}"
}