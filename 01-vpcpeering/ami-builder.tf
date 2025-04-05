# resource "aws_instance" "webserver-ami" {
#   ami           = "ami-002f6e91abff6eb96"
#   instance_type = "t2.micro"
#   user_data = file("./scripts/webserver-ami-userdata.sh")
#   tags = {
#     Name = "webserver-ami"
#   }
# }

# resource "aws_ami_from_instance" "apache-webserver-ami" {
#   name               = "apache-webserver-ami"
#   source_instance_id = aws_instance.webserver-ami.id
# }


# resource "aws_imagebuilder_image" "example" {
#   distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.example.arn
#   image_recipe_arn                 = aws_imagebuilder_image_recipe.example.arn
#   infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.example.arn
# }

resource "aws_imagebuilder_image_recipe" "example" {
  name         = "apache-webserver-receipe"
  version      = "1.0.0"
  parent_image = "ami-002f6e91abff6eb96" # Base AMI

  component {
    component_arn = "arn:aws:imagebuilder:ap-south-1:aws:component/amazon-linux-extras/1.0.0" # Example component
  }

  tags = {
    Name = "example-recipe"
  }
}