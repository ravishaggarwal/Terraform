# Terraform
Terraform repository

This exercise includes creation of below resources:
1)	Multiple VPC, Subnet
2)	 Internet Gateway 
3)	Subnets
4)	Route Tables
5)	Security group
6)	EC2 Instances 
7)	S3 Buckets 

The above resources created for both Dev and Prod infrastructure via maintaining Terraform workspace.
Like We create two different workspaces – dev and Prod and execute terraform init and terraform apply by selecting each workspace.
Command:
“terraform workspace new <workspaceName>” (we have two workspaces, dev and prod).
Select the required workspace by using the below command.
Command:
“terraform workspace select <workspace>” 
And then apply commands:  terraform init and terraform apply respectively.
Explanation of execution of each module mentioned above:
Each AWS resource is created by using Modules to adhere the structure norms.
The Main Script contains below resources:
1)	Provider resource
2)	 modules for creating each AWS resource mentioned above
3)	 null resource to append the output of each module to file

•	vpc module
The vpc module get called with input of Cidr block and env variables that is currently mentioned in the main variables.tf file. In the VPC main.tf, VPC is being created by using aws_vpc resource and inputs are cidr block and env, rest all are default ones. The vpc.id and cidr in the output.tf will be used in subnet and later modules as input.
Inputs are:	
1)	cidr block   Value fetched from defined Map by using “lookup” on the basis of input workspace name (say dev or prod).
2)	env variable  Workspace name (say dev or prod)
 Outputs are:
1)	vpc Id  Generated VPC ID 
2)	Cidr block cidr value.

•	Subnet Module
The subnet module called with input of vpc.id generated after creation of VPC and cidrblock, the subnet module will use the “cidrsubnet” - "${cidrsubnet(var.cidrblock_subnet, 8, count.index)}"function to select the cidr for subnet. The subnet ids, subnet ips and count in the output.tf will be used in later modules.
Inputs are:	
1)	Vpc id  The output of previous vpc mod
2)	vpc cidr block   The output of previous vpc module vpc.id passed as input.
3)	env variable  Workspace name (say dev or prod)
 Outputs are:
1)	subnet Ids (subnet_ids)  Generated all subnet ids.
2)	Subnet count  Count how many subnets got generated.
3)	Subnet Ips  subnet cidr value.

•	Internet Gateway Module
The internet gateway module called with input of vpc.id generated after creation of VPC and outputs.tf contains the internetgateway.id which will be used in route module to attach the internet gateway with route.
Inputs are:	
1)	Vpc id  The output of previous vpc mod
2)	env variable  Workspace name (say dev or prod)
 Outputs are:
1)	InternetGatewayId  Generated Internet gateway details 

•	route Module
The route module called with input of vpc.id generated after creation of VPC, subnet Ids generated in subnet module and internetgateway id generated in internet gateway module and subnet count. Route table association resource also part of route module.
Inputs are:	
1)	Vpc id  The output of previous vpc mod
2)	InternetGatewayId – Generated Internet gateway details 
3)	subnet Ids (subnet_ids)  Generated all subnet ids.
4)	Subnet count  Count of subnets got generated
5)	env variable  Workspace name (say dev or prod)
 Outputs are:
1)	route Id  Generated route ID 


•	Security group Module
The security group module called with input of vpc.id generated after creation of VPC, subnet IPs generated in subnet module, subnet count. The cidr range for ingress are taken from the subnet IPs that being passed while calling security group module and cidr_range for egress is currently hardcode with all source IPs, rest protocol, to and from port details for both ingress and egress are hardcoded in the module main file.  The output of the security group is Security Group Name that is being created.
	Inputs are:	
1)	Vpc id  The output of previous vpc mod
2)	subnet IPs (subnet Ips)  Generated all subnet ips – cidr’s
3)	Subnet count  Count of subnets got generated
4)	env variable  Workspace name (say dev or prod)
 Outputs are:
1)	security group name  Generated security group name

•	Instance Module
The instance (EC2) module called with input of security group name that being generated in security group module and subnet Ids that got generated in subnet module. The ami chosen while creating the Ec2 instance is fetched by using data resource “aws_ami” and apply filter to retrieve the required ami. The bootstrapping script is provided in userdata.tpl file and accessed in main script by using “template_file” and loaded by using the file -path module  “${file("${path.module}/<filename”
The output of the instance module is EC2 Server Id and Sever IP i.e. Public IPs.
	Inputs are:	
1)	security group name  Generated security group name
2)	subnet Ids (subnet_ids)  Generated all subnet ids.
3)	env variable  Workspace name (say dev or prod)
 Outputs are:
1)	Instance Id  Generated instance ID 
2)	Instance Ip  Generated instance IP.

•	S3 Bucket
The storage module called with input of environment variable. In the main script of storage the “random_id” resource is being used to create the random number that will be provided in the end of bucket name to maintain its uniqueness. 
Inputs are:	
1)	env variable  Workspace name (say dev or prod)
 Outputs are:
1)	bucketName  Generated name of the bucket in S3. 

•	Null_resource
The null_resource resource is defined in the main script that will use “local-exe” provisioner to store the outputs.tf of the main/root folder in to the file. The outputs.tf file in the root/main folder is having outputs resources defined in each module.

