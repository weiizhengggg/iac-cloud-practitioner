provider "aws"{
    region = "ap-southeast-1"
    access_key = "YourAWSAccessKey"
    secret_key = "YourAWSSecretKey"
}

resource "aws_security_group" "wzSGTerraform"{
    name = "default-vpc-security-group"
    description = "Allow SSH and HTTP access"
    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow SSH from anywhere"
    }

    ingress{
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow HTTP from anywhere"
    }

    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all outbound traffic"
    }

    tags = {
        Name = "DefaultVPCSecurityGroup"
    }
}

resource "aws_instance" "wzEC2Terraform1"{
    ami = "ami-06650ca7ed78ff6fa"
    instance_type = "t2.micro"
    key_name = "wzfirst"
    vpc_security_group_ids = [aws_security_group.wzSGTerraform.id]
    tags = {
        Name = "1-Terraform-EC2"
    }
}

resource "aws_instance" "wzEC2Terraform2"{
    ami = "ami-06650ca7ed78ff6fa"
    instance_type = "t2.micro"
    key_name = "wzfirst"
    vpc_security_group_ids = [aws_security_group.wzSGTerraform.id]
    ebs_block_device {
        device_name = "/dev/xvdf"
        volume_size = 10
        volume_type = "gp2"
    }
    tags = {
        Name = "2-Terraform-EC2"
    }
}