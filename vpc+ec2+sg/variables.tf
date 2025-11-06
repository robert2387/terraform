variable "vpc_id" {
  type    = string
  default = "vpc-067847c3b8ff00403"
}

variable "instance_type" {
    default = "t3.micro"
}

variable "region" {
    default = "eu-north-1"
}

variable "ami" {
    default = "ami-055e4d03ab1de5def"
}