# Imagem que simula uma VM Ubuntu acessivel por SSH (substitui a EC2)
FROM ubuntu:22.04
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server sudo python3 && \
    mkdir -p /run/sshd && \
    useradd -m -s /bin/bash ubuntu && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu && \
    mkdir -p /home/ubuntu/.ssh && chmod 700 /home/ubuntu/.ssh && \
    chown ubuntu:ubuntu /home/ubuntu/.ssh
EXPOSE 22 80
CMD ["/usr/sbin/sshd", "-D"]
