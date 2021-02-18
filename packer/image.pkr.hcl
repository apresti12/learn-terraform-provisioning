variable "region" {
  type    = string
  default = "us-east-1"
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }


# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioners and post-processors on a
# source.
source "amazon-ebs" "example" {
  ami_name      = "lamp-server-${local.timestamp}"
  instance_type = "t2.micro"
  region        = var.region
  source_ami = "ami-047a51fa27710816e"
  # source_ami_filter {
  #   filters = {
  #     name                = "amzn2-ami-hvm-2.0.20210126.0-x86_64-gp2"
  #     root-device-type    = "ebs"
  #     virtualization-type = "hvm"
  #   }
  #   most_recent = true
  #   owners      = ["099720109477"]
  # }
  ssh_username = "ec2-user"
}

# a build block invokes sources and runs provisioning steps on them.
build {
  sources = ["source.amazon-ebs.example"]

  provisioner "shell" {
    script = "../scripts/setup.sh"
  }
   provisioner "shell" {
    script = "../scripts/setup2.sh"
  }
  provisioner "file" {
    source = "../app/index.html"
    destination = "/var/www/html/index.html"
  }
}
