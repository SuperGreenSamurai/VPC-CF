#there are 2 buckets - there is 1 role. #Logs access role. 
#change values here (ex: region, ami, key) if needed.  

images_bucket_name = "images-bucket"

logs_bucket_name = "logs-bucket"

logs_access_role_name = "logs-access-role"

aws_region = "us-west-2"

cidr_block_vpc = "10.1.0.0/16"

instance_ami = "ami-0da4b082c0455e0a0" # RedHat Linux AMI ID

instance_type = "t2.micro"

#ebs volume size
volume_size = 20

#launch template and ec2 key name
key_name = "coalfire"

#subnets
sub1 = "10.1.0.0/24"

sub2 = "10.1.1.0/24"

#private subnets
sub3 = "10.1.2.0/24"

sub4 = "10.1.3.0/24"

#availability zones
az1 = "us-west-2a"
az2 = "us-west-2b"

#public cidr range in security groups
public_cidr_block = "0.0.0.0/0"

#application name
name_prefix = "MyApp-"

