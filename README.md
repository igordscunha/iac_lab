DevOps - Igor Cunha
Infraestrutura como código com Terraform (provisionamento de um contêiner Ubuntu via Docker, simulando uma VM) e Ansible (instalação do NGINX).

## Uso
```bash
ssh-keygen -t ed25519 -N "" -f ~/.ssh/iac_lab_key
terraform init && terraform apply
ansible-playbook -i inventory.ini playbook.yml   # http://localhost:8080
terraform destroy
```
