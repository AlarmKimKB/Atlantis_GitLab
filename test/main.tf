provider "aws" {
  region = "ap-northeast-2"
}

terraform {
  backend "s3" {
    bucket = "{Remote_Backend}"
    key    = "{Key}"
    region = "{Region}"
    dynamodb_table = "{DynamoDB}"
    # encrypt        = true
  }
}

resource "aws_instance" "test_app" {
  ami           = "ami-0c76973fbe0ee100c"
  instance_type = "t2.micro"

  tags = {
    Name = "atlantis-test"
  }
}