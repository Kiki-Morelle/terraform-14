# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "aws_instance" "web" {
  ami                                  = "ami-081b0a6eac00b4f53"
  associate_public_ip_address          = true
  availability_zone                    = "us-east-1c"
  instance_type                        = "t3.micro"
  key_name                             = "mykey2"
  security_groups                      = ["launch-wizard-6"]
  subnet_id                            = "subnet-00e65499567bdb056"
  tags = {
    Name = "dev-app-server"
  }
  tags_all = {
    Name = "dev-app-server"
  }
}