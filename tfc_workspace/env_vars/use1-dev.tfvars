##############################
# Standard Project Variables #
##############################
vcs_branch        = "main"
aws_region        = "us-east-1"
region_code       = "use1"
environment       = "dev"

############################
# Custom Project Variables #
############################
ec2_instance_type                                       = "t2.micro"
ec2_instance_ami                                        = "ami-0cf4380e9a9430646" #al2023-ami-minimal-2023.7.20250331.0-kernel-6.1-x86_64, 2023.0.20250403
arm_ec2_instance_ami                                    = "ami-000dd7709fc500032" #al2023-ami-minimal-2023.7.20250331.0-kernel-6.1-arm64, 2023.0.20250403
instance_encryption_key_name                            = "aws-biotornic-dev"
cp_od_capacity_provider_target_capacity                 = 100
