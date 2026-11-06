terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

variable "ssh_public_key_path" {
  description = "Chave publica autorizada para o usuario ubuntu"
  type        = string
  default     = "~/.ssh/iac_lab_key.pub"
}

# Imagem Ubuntu com SSH (equivalente a AMI)
resource "docker_image" "ubuntu_ssh" {
  name = "iac-lab-ubuntu-ssh:latest"
  build {
    context = path.module
  }
}

# Rede isolada (equivalente a VPC)
resource "docker_network" "lab_net" {
  name = "iac-lab-net"
}

# "Instancia" Ubuntu (equivalente a EC2 t2.micro)
resource "docker_container" "web" {
  name     = "iac-lab-web"
  image    = docker_image.ubuntu_ssh.image_id
  hostname = "iac-lab-web"
  memory   = 1024

  networks_advanced {
    name = docker_network.lab_net.name
  }

  # Portas expostas (equivalente ao security group): SSH (22) e HTTP (80)
  ports {
    internal = 22
    external = 2222
  }
  ports {
    internal = 80
    external = 8080
  }

  upload {
    file    = "/home/ubuntu/.ssh/authorized_keys"
    content = file(pathexpand(var.ssh_public_key_path))
  }
}

output "ssh_command" {
  value = "ssh -i ~/.ssh/iac_lab_key -p 2222 ubuntu@localhost"
}

output "nginx_url" {
  value = "http://localhost:8080"
}
