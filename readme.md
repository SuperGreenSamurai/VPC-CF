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

![My-App-Apache-Redhat-Screenshot](https://github.com/user-attachments/assets/3ed4065c-53c5-49fc-9047-714f06430771)



b. Login to the stand-alone EC2 instance in sub2 and take a screenshot of the terminal while logged in. Include
this screenshot in your documentation.


![terminal-ss](https://github.com/user-attachments/assets/7264b14e-a8d4-4248-b622-5053001f1414)

c. An architecture diagram


![AWS-VPC-Diagram-final](https://github.com/user-attachments/assets/4c681ebb-68e3-4d27-b287-1a077b7c18e9)


File Tree

![files](https://github.com/user-attachments/assets/1f99520d-45d9-4b4d-95b6-8e91b2bffea2)


0-Auth.tf

![0-Auth](https://github.com/user-attachments/assets/14a4cd43-4e0c-40ad-a3fd-ab05182616e0)


1-VPC-EC2

![1-VPC-EC2](https://github.com/user-attachments/assets/5e1e0f0b-df26-46c5-9caa-3f30bf8e7084)

SSH into EC2
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connect-linux-inst-ssh.html

The SSH connection gave me the most trouble. I understand port 22 must be open in the security group. 
What I didn't know is that the Linux Redhat AMI isn't compaible with AWS Direct Connect, so I used SSH client and powershell (GCP is better here in my opinion). 


2-Subnets

![2-Subnet_1](https://github.com/user-attachments/assets/b00c7fd5-8c32-4eea-950a-1245bdca249c)

![2-Subnets_2](https://github.com/user-attachments/assets/6d2fae59-fd2f-4c00-8981-9aab770686c2)

3-IGW

![3-IGW](https://github.com/user-attachments/assets/598d900b-ae43-48c0-9beb-9beffb72a28b)


4-EIP_NAT GW

![4-EIP_NAT](https://github.com/user-attachments/assets/3f2bbdc7-f7b8-4050-98cc-81d261a338ed)

5- Route Tables

![5-Route_1](https://github.com/user-attachments/assets/2a073c02-10a1-49f1-9328-e54c889e6d45)


![5-Route_2](https://github.com/user-attachments/assets/a43dcc60-5d28-40ac-819e-9fec1fa242f1)

6-All-SG

![6-All-SG_1](https://github.com/user-attachments/assets/e60cffa0-0040-4f4f-a297-6d635147a612)

![6-All-SG_2](https://github.com/user-attachments/assets/66a19b7c-ef23-4ee5-9f0a-19ecc686d53c)


7 - Launch Template

![7-launchtemplate](https://github.com/user-attachments/assets/cdb35b8e-9ea4-426b-b966-4a1299133b78)

8 - Target Group

![8-target-group](https://github.com/user-attachments/assets/b11ee3cd-4e88-4d80-9e26-33181bf53793)

9 - Load Balancer

![9-LoadBalancer](https://github.com/user-attachments/assets/14172e93-0f56-4053-9989-4773f2c70ec8)

10- ASG
I decided to add a name_prefix arguement with a variable to easily re-name a standard "company asg".
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group#argument-reference

target_tracking_configuration - A requirement I looked up. I decided to use "ASGAverageCPUUtilization" at a target value of 75%. Which gives My_App- enough
time to scale out, adding resilency, while being cost-effective.  

Describes a scaling metric for a predictive scaling policy. 
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy#argument-reference

![10-ASG_1](https://github.com/user-attachments/assets/bcbea23c-fbe3-4dc9-b952-1a19c1792d15)

![10-ASG_2](https://github.com/user-attachments/assets/dc06fe56-4742-40db-b689-c1e012dd19a9)

11- S3
S3 bucket_suffix

Because bucket names need to be globally unique, and I'm quite sure "Logs" and "Images" were snapped up many moons ago, I added randomizer string as a suffix;
to ensure I could generate a unique bucket name. This should work as a POF for a client. 

Terrraform registry - AWS bucket lifecycle configuration
https://docs.aws.amazon.com/AmazonS3/latest/userguide/how-to-set-lifecycle-configuration-intro.html

![11-S3_1](https://github.com/user-attachments/assets/33560396-8292-4b96-a2fa-79cebb1fa09a)

![11-S3_2](https://github.com/user-attachments/assets/03447656-ed75-4497-88c6-d24cecef01ca)

![11-S3_3](https://github.com/user-attachments/assets/a7508906-c219-49c9-a7cf-ae9e7d96dff9)


12- Outputs

![12-outputs](https://github.com/user-attachments/assets/8da540b4-4b9e-45fa-b761-30f4fade2785)


13. TF Vars

Change necessary here; TFvars file assigns values to the variable listed in variable.


![13-tfvars_1](https://github.com/user-attachments/assets/9ee9b6b9-ddb9-467f-8cd2-58342ae25e6c)

![13-tfvars_2](https://github.com/user-attachments/assets/70578157-ee90-4ddc-809b-88ca9b9806cc)


14. Variables

![14-variable_1](https://github.com/user-attachments/assets/129ba61a-27e8-4f12-89fc-51007fa4db52)

![14-variable_2](https://github.com/user-attachments/assets/d271bf91-a779-47a6-8a07-898d0d2854e9)

![14-variable_3](https://github.com/user-attachments/assets/ddc5acf4-25f1-44ad-beca-59adfcf4b639)
