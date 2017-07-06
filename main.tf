#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-30628649
#
# Your subnet ID is:
#
#     subnet-be42e9f7
#
# Your security group ID is:
#
#     sg-4069a238
#
# Your Identity is:
#
#     RiverIsland-training-dolphin
#


# module "example" {
#   source = "./example-module"
#   command = "echo Goodbye world"
# }

terraform {
  backend "atlas" {
    name = "pocketrocket64/training"
  }
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  instance_type          = "t2.micro"
  count                  = 2
  ami                    = "ami-30628649"
  subnet_id              = "subnet-be42e9f7"
  vpc_security_group_ids = ["sg-4069a238"]

  tags {
    "Identity" = "RiverIsland-training-dolphin"
    "Name"     = "PocketRocket"
    "Sex"      = "AsMuchAsPossible"
    "Count"    = "web ${count.index+1}"
  }
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}
