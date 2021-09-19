# Write IAAC script for provision of a 3-tier application in AWS #


# Solution 

This repo (iaac-task-1) contains terraform configuration files for the above assignment. The configuration can deploy follwoing resources: 

## Requirements

| Name | Version |
|------|---------|
| aws | ~> 3.0 |
| terraform | ~> 1.0.0 |


## It will create the following resources in AWS.

- VPC
  # aws_vpc.demovpc will be created

    - Internet Gateway
        # aws_internet_gateway.demo_igw will be created
    - 2 Public Subnets
        # aws_subnet.demo_public_subnet_1 will be created
        # aws_subnet.demo_public_subnet_2 will be created
    - 2 Private Subnets
        # aws_subnet.demo_private_subnet_1 will be created
        # aws_subnet.demo_private_subnet_2 will be created
    - NAT Gateway
        # aws_nat_gateway.demo_ngw will be created
    - Elastic IP for NAT Gateway
        # aws_eip.demo_eip will be created
    - Public route table
         # aws_route_table.demo_public_route_table will be created
    - Private route table
         # aws_route_table.demo_private_route_table will be created
         
    - Route Table Association
        # aws_route_table_association.demo_public_rt_association_1 will be created
        # aws_route_table_association.demo_public_rt_association_2 will be created
        # aws_route_table_association.demo_private_rt_association_1 will be created
        # aws_route_table_association.demo_private_rt_association_2 will be created
        
    - NACL
        # aws_network_acl.nacl will be created
        # aws_network_acl_rule.nacl_rule_egress will be created
        # aws_network_acl_rule.nacl_rule_ingress will be created
    - Load Balancers
        # aws_lb.public_lb will be created
        # aws_lb.private_lb will be created
        # aws_lb_listener.private_lb_listener_80 will be created
        # aws_lb_listener.public_lb_listener_80 will be created

    - Launch template for app tier and web tier
        # aws_launch_template.app_tier_lt will be created
        # aws_launch_template.web_tier_lt will be created

    - Auto-scaling group for app tier and web tier
        # aws_autoscaling_group.app_asg will be created
        # aws_autoscaling_group.web_asg will be created
        # aws_autoscaling_attachment.app_asg_attachment will be created
        # aws_autoscaling_attachment.web_asg_attachment will be created

    - Target group for app tier and web tier
        # aws_alb_target_group.app_target_group will be created
        # aws_alb_target_group.web_target_group will be created

    - Internal ALB
        # aws_lb.private_lb will be created
    - Public-facing ALB
        # aws_lb.public_lb will be created
    - Security groups for app tier, web tier, internal ALB, public-facing ALB and RDS
        # aws_security_group.app_sg will be created
        # aws_security_group.rds_sg will be created
        # aws_security_group.web_sg will be created
        # aws_security_group.private_lb_sg will be created
        # aws_security_group.public_lb_sg will be created
        # aws_security_group_rule.app_sg_egress will be created
        # aws_security_group_rule.app_sg_igress_22 will be created
        # aws_security_group_rule.app_sg_igress_80 will be created
        # aws_security_group_rule.private_lb_sg_egress will be created
        # aws_security_group_rule.private_lb_sg_igress_80 will be created
        # aws_security_group_rule.public_lb_sg_egress will be created
        # aws_security_group_rule.public_lb_sg_igress_443 will be created
        # aws_security_group_rule.public_lb_sg_igress_80 will be created
        # aws_security_group_rule.rds_sg_egress will be created
        # aws_security_group_rule.rds_sg_igress_3306 will be created
        # aws_security_group_rule.web_sg_egress will be created
        # aws_security_group_rule.web_sg_igress_22 will be created
        # aws_security_group_rule.web_sg_igress_80 will be created
    - IAM role for app tier to access s3, cloudwatch and rds
        # aws_iam_instance_profile.aws_ec2_profile will be created
        # aws_iam_policy.ec2_policy will be created
        # aws_iam_policy_attachment.ec2_policy_attach will be created
        # aws_iam_role.ec2_role will be created
    - Route53 private hosted zone
        # aws_route53_zone.private_route53_zone will be created
    - DNS record sets for app tier and db tier in private hosted zone 
        # aws_route53_record.app will be created
        # aws_route53_record.db will be created
    - RDS
        # aws_db_instance.rds will be created
        # aws_db_subnet_group.rds_subnet_group will be created

The architecure diagram is given below.

![image](tcs-assignment-1.png)

# How to run this code

- Clone this repo on your local machine

- Make sure you installed and configured `aws-cli` properly and configured with Access_Key and Secret_Access_Key  

- Then initialize terraform
`terraform init`

- Then plan the execution
`terraform plan`

- Then apply the plan
`terraform apply` ==> type `yes` when prompted

- To destroy this configuration
`terraform destroy`



## Resources

| Name | Type |
|------|------|
| [aws_alb_target_group.app_target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_target_group) | resource |
| [aws_alb_target_group.web_target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_target_group) | resource |
| [aws_autoscaling_attachment.app_asg_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_attachment) | resource |
| [aws_autoscaling_attachment.web_asg_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_attachment) | resource |
| [aws_autoscaling_group.app_asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_group.web_asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_db_instance.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.rds_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_eip.nat_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_iam_instance_profile.aws_ec2_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.ec2_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.ec2_policy_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.ec2_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_key_pair.tcs_server_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_launch_template.app_tier_lt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_launch_template.web_tier_lt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_lb.private_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb.public_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.private_lb_listener_80](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.public_lb_listener_80](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_nat_gateway.nat_gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_network_acl.nacl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_network_acl_rule.nacl_rule_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.nacl_rule_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_route53_record.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.private_route53_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_route_table.private_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_rt_association_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.private_rt_association_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_rt_association_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_rt_association_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.app_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.private_lb_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.public_lb_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.rds_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.web_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.app_sg_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.app_sg_igress_22](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.app_sg_igress_80](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.private_lb_sg_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.private_lb_sg_igress_80](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.public_lb_sg_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.public_lb_sg_igress_443](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.public_lb_sg_igress_80](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.rds_sg_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.rds_sg_igress_3306](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.web_sg_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.web_sg_igress_22](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.web_sg_igress_80](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_subnet.private_subnet_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private_subnet_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnet_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnet_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_ami.amazon_linux_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Outputs

| Name | Description |
|------|-------------|
| app\_endpoint\_private | n/a |
| db\_endpoint\_private | n/a |
| private\_lb\_endpoint | n/a |
| public\_lb\_endpoint | n/a |
