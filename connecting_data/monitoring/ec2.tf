######################################################
#              AWS INSTANCE CONFIGURATION            #
######################################################

module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.1"

  name = local.name

  subnet_id              = element(module.vpc.public_subnets, 0)
  vpc_security_group_ids = [module.security_group_instance.security_group_id]

  associate_public_ip_address = true

  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  user_data = file("${path.module}/scripts/bootstrap.sh")

  tags = local.tags
}
