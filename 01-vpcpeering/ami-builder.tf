# # resource "aws_instance" "webserver-ami" {
# #   ami           = "ami-002f6e91abff6eb96"
# #   instance_type = "t2.micro"
# #   user_data = file("./scripts/webserver-ami-userdata.sh")
# #   tags = {
# #     Name = "webserver-ami"
# #   }
# # }

# # resource "aws_ami_from_instance" "apache-webserver-ami" {
# #   name               = "apache-webserver-ami"
# #   source_instance_id = aws_instance.webserver-ami.id
# # }


# # resource "aws_imagebuilder_image" "example" {
# #   distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.example.arn
# #   image_recipe_arn                 = aws_imagebuilder_image_recipe.example.arn
# #   infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.example.arn
# # }

# resource "aws_imagebuilder_image_recipe" "apache-webserver-receipe" {
#   name         = "apache-webserver-receipe"
#   version      = "1.0.0"
#   parent_image = "ami-002f6e91abff6eb96" # Base AMI

#   component {
#     component_arn = "arn:aws:imagebuilder:ap-south-1:aws:component/amazon-cloudwatch-agent-linux/1.0.1" # Example component
#   }

#   tags = {
#     Name = "apache-webserver-receipe"
#   }
#   user_data_base64 = base64encode(file("./scripts/webserver-ami-userdata.sh"))
# }



# resource "aws_imagebuilder_infrastructure_configuration" "apache-webserver-infra-config" {
#   name                   = "apache-webserver-infra-config"
#   instance_types         = ["t2.micro"]
#   terminate_instance_on_failure = true
#   instance_profile_name = "ec2-s3-full-access-role"
#   tags = {
#     Name = "apache-webserver-infra-config"
#   }
# }


# resource "aws_imagebuilder_distribution_configuration" "apache-webserver-distribution" {
#   name = "apache-webserver-distribution"

#   distribution {
#     region = "ap-south-1"

#     ami_distribution_configuration {
#       name = "apache-webserver-{{imagebuilder:buildDate}}"
#     }
#   }

#   tags = {
#     Name = "apache-webserver-distribution"
#   }
# }

# # Create an Image Pipeline
# resource "aws_imagebuilder_image_pipeline" "apache-webserver-pipeline" {
#   name         = "apache-webserver-pipeline"
#   image_recipe_arn                 = aws_imagebuilder_image_recipe.apache-webserver-receipe.arn
#   infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.apache-webserver-infra-config.arn
#   distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.apache-webserver-distribution.arn

#   tags = {
#     Name = "apache-webserver-pipeline"
#   }
# }

# #arn:aws:iam::789382984861:role/ec2-s3-full-access-role

