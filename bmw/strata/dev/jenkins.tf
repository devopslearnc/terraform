module "jenkins_ec2" {
  source = "../../library/ec2"

  instance_type            = "t3.micro"
  name                     = "jenkins-dev"
}
 
