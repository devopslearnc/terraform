module "jenkins_ec2" {
  source = "../../library/ec2"

  instance_type            = "m7i-flex.large"
  name                     = "dev-jenkins"
  key_name = "dev-jenkins-new"
}
 
