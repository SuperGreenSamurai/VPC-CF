Project:

**AWS TECHNICAL CHALLENGE - COALFIRE**
(due 1-6-24)

Hello!  This project serves as a proof of concept for a VPC built with the AWS cloud. 

Overview:

This repo builds a VPC with 4 subnets (2 public, 2 private), an ASG & Application Load Balancer that distributes instances in the private subnets.
In addition, this repo creates two S3 buckets (Logs, Images) each with two subfolders; and a role that has permission to write to the Logs bucket.  

Overall it was pretty straightforward, the instructions didn't call for modules, so I didn't build modules. 
I pulled my code from the Terraform registry; or from my previous repos and Frankenstein-ed it together. 
I used generic variables for most of the resources, and took that approach after studying the Coalfire Repo. 

Visuals of the .tf files in my configuaration follow. 

Requirements:

a. Working Terraform code in a public GitHub repository.

b. The URL of your GitHub repository.

c. An architecture diagram.

d. A document describing your solution, which includes your screenshot and cites any references used.

e. A functional README for your repository.




Deliverables:

a. 1 application load balancer (ALB) that listens on TCP port 80 (HTTP) and forwards traffic to the ASG in subnets
sub3 and sub4 on port 443

![My-App-Apache-Redhat-Screenshot](https://github.com/user-attachments/assets/b809edcd-9622-4236-afb3-10e16016f366)




b. Login to the stand-alone EC2 instance in sub2 and take a screenshot of the terminal while logged in. Include
this screenshot in your documentation.

![terminal-ss](https://github.com/user-attachments/assets/cbed84dd-5554-4a93-b74b-52b49764115c)



c. An architecture diagram

![AWS-VPC-Diagram-final](https://github.com/user-attachments/assets/30dee58a-f6ba-4132-b49f-bf40015504b7)



File Tree

![files](https://github.com/user-attachments/assets/460c0e6f-e384-4d88-b3c3-779d06fe7792)



0-Auth.tf

![0-Auth](https://github.com/user-attachments/assets/b101d153-d7c4-4b9d-acef-bd4a56169793)


1-VPC-EC2

![1-VPC-EC2](https://github.com/user-attachments/assets/e45818d9-7cd1-478d-819c-bb0989606a0b)


SSH into EC2
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connect-linux-inst-ssh.html

The SSH connection gave me the most trouble. I understand port 22 must be open in the security group. 
What I didn't know is that the Linux Redhat AMI isn't compaible with AWS Direct Connect, so I used SSH client and powershell (GCP is better here in my opinion). 


2-Subnets

![2-Subnet_1](https://github.com/user-attachments/assets/f93cc2c3-dc8e-4503-b3bc-6e081d72b3aa)

![2-Subnets_2](https://github.com/user-attachments/assets/a141296b-d9f6-4793-88ee-78a2358d16da)


3-IGW

![3-IGW](https://github.com/user-attachments/assets/9d292279-4e0f-4be6-83ae-201438b02913)



4-EIP_NAT GW

![4-EIP_NAT](https://github.com/user-attachments/assets/50f8ecaa-c1a1-4e6f-aa79-c60196f37df1)



5- Route Tables

![5-Route_1](https://github.com/user-attachments/assets/4bb7e96b-3c2f-4f3a-b41b-fe4c7a1e682f)

![5-Route_2](https://github.com/user-attachments/assets/231ce667-a9d2-47a5-85ea-1b214a88d842)


6-All-SG

![6-All-SG_1](https://github.com/user-attachments/assets/82ebb83f-d4ca-47a6-b35f-e9384160ae46)

![6-All-SG_2](https://github.com/user-attachments/assets/fca0e419-2623-4302-a2f2-97a00f08e134)


7 - Launch Template

![7-launchtemplate](https://github.com/user-attachments/assets/25187d81-87b3-44c2-8193-2c973015d93a)


8 - Target Group

![8-target-group](https://github.com/user-attachments/assets/373f6221-7d3b-402c-ba81-0690e30f4b7e)


9 - Load Balancer

![9-LoadBalancer](https://github.com/user-attachments/assets/d733cb3c-09ea-465a-bc39-ae935479d74d)


10- ASG
I decided to add a name_prefix arguement with a variable to easily re-name a standard "company asg".
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group#argument-reference

target_tracking_configuration - A requirement I looked up. I decided to use "ASGAverageCPUUtilization" at a target value of 75%. Which gives My_App- enough
time to scale out, adding resilency, while being cost-effective.  

Describes a scaling metric for a predictive scaling policy. 
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy#argument-reference

![10-ASG_1](https://github.com/user-attachments/assets/24329db7-9212-462c-9bb8-fd65753760f4)

![10-ASG_2](https://github.com/user-attachments/assets/6c97455b-68be-43fe-a856-e4c414271851)


11- S3
S3 bucket_suffix

Because bucket names need to be globally unique, and I'm quite sure "Logs" and "Images" were snapped up many moons ago, I added randomizer string as a suffix;
to ensure I could generate a unique bucket name. This should work as a POF for a client. 

Terrraform registry - AWS bucket lifecycle configuration
https://docs.aws.amazon.com/AmazonS3/latest/userguide/how-to-set-lifecycle-configuration-intro.html


![11-S3_1](https://github.com/user-attachments/assets/e7bdc7a7-4cc1-466d-93ef-e6ecbd92f37d)

![11-S3_2](https://github.com/user-attachments/assets/840ae4f0-f1d1-43c9-b756-1a51fee0ed3e)

![11-S3_3](https://github.com/user-attachments/assets/1c93d734-1a13-4549-9f29-177829688076)


12- Outputs

![12-outputs](https://github.com/user-attachments/assets/e403875e-17c7-4e31-8409-e61b87416f00)



13. TF Vars

Change necessary here; TFvars file assigns values to the variable listed in variable.


![13-tfvars_1](https://github.com/user-attachments/assets/f75cdc71-6e0f-4cfe-a424-7293a0ccd869)

![13-tfvars_2](https://github.com/user-attachments/assets/809c488b-e43e-4771-a5aa-9c5fade6ad56)


14. Variables

![14-variable_1](https://github.com/user-attachments/assets/bb56245a-0b79-467f-a8a2-620f1ca22e2a)

![14-variable_2](https://github.com/user-attachments/assets/82cd60be-ccdd-4db4-948c-9787e90582a2)


![14-variable_3](https://github.com/user-attachments/assets/13615f17-9239-4774-b980-da640aa66800)

