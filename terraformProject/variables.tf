variable "region"{
    description = "Aws region"
    default = "us-east-1"

}

variable "key_name"{
    type = string
    default = "my_key_pair"
}

variable "ami_id"{
    type = string
    default = "ami-067d1e60475437da2"
}

variable "default_subnet_ids" {
  description = "default list of subnets"
  type = list(string)
  default = [ 
    "subnet-0c9a934f3ab4a5091",
    "subnet-0db9c08e902d59229",
    "subnet-053f132f2e2cb24e0",
    "subnet-075a452009e940e5b" ]
}

variable "public_key" {
    type = string
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCx3z9oMQlrJi3HQhjHdwQIsqhFFx2ZFCaPp2dndmgFP0bYk5gRjjRN8GMaTHwENX/BTMXL57fjPsMpaA2PMeqnFQrpUkZoDMd39RGqEAclEDwufdpgvBbR0UcRfxcgYro5mNE9Yu9R6doCuZ9OXiHmrGatv35bAT8RY1wbiQGsv5aNZA9nX6PxH39bGICCQjuqz8Woq4hvAbyWrKVbWjlLdXzgvYnsZTBqa+u2eavWcXbOrj+gCFEuQ1Ce+QqKllY1ezl1fXfPa0hAJLM3g3Y3IMLIzQPX+GbL1sY7SqtcnSXQcK2XKlHKZaLkcVYpHSVfneV6FZpWNoCfTrXnA4cV admin@DESKTOP-P2PTHR4"
  
}

variable "default_vpc_id" {
  description = "default vpc id"
  type = string
  default = "vpc-043d42f6449b393cb"
}

