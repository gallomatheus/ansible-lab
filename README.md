# Ansible ⚙️

Documentação com comandos essenciais do Ansible utilizando Linux, Vagrant e múltiplos hosts.

---

# Verificar instalação

## Ver versão do Ansible
ansible --version


## Ver localização do Ansible
which ansible

# Inventory:
## Exemplo inventory:
[app]
app01 ansible_host=192.168.1.3

[db]
db01 ansible_host=192.168.1.4

# Testes de conectividade:
## Testar ping em todos hosts
ansible all -i hosts -m ping

## Testar grupo específico
ansible app -i hosts -m ping

## Ver hostname remoto
ansible all -i hosts -a "hostname"

## Ver uptime remoto
ansible all -i hosts -a "uptime"

# Comandos Ad-Hoc:
## Atualizar pacotes
ansible all -i hosts -b -a "apt-get update"

## Instalar nginx
ansible app -i hosts -b -m apt -a "name=nginx state=present"

## Reiniciar serviço
ansible app -i hosts -b -m service -a "name=nginx state=restarted"

## Criar diretório
ansible all -i hosts -b -m file -a "path=/app state=directory"

## Copiar arquivo
ansible all -i hosts -b -m copy -a "src=index.html dest=/var/www/html/index.html"

## Criar usuário Linux
ansible all -i hosts -b -m user -a "name=devops state=present"

# Playbooks:
## Executar playbook
ansible-playbook -i hosts nginx.yml

## Executar com verbose
ansible-playbook -i hosts nginx.yml -v

## Mais detalhes
ansible-playbook -i hosts nginx.yml -vvv

## Simular execução
ansible-playbook -i hosts nginx.yml --check

## Ver diferenças
ansible-playbook -i hosts nginx.yml --diff

## Estrutura básica playbook
- hosts: app
  become: yes

### Tasks
    - name: Instalar nginx
      apt:
        name: nginx
        state: present

## Módulos importantes
### apt
  - name: Instalar pacote
    apt:
      name: nginx
      state: present

### service
  - name: Iniciar serviço
    service:
      name: nginx
      state: started
      enabled: yes
    
### copy
  - name: Copiar arquivo
    copy:
      src: index.html
      dest: /var/www/html/index.html

### file
  - name: Criar diretório
    file:
      path: /app
      state: directory

### git
  - name: Clonar repositório
    git:
      repo: https://github.com/user/repo.git
      dest: /app

### shell
  - name: Executar shell
    shell: docker ps

### command
  - name: Executar comando
    command: uptime

# Variables:
## Exemplo variável
  vars:
    app_port: 8080

## Utilizar variável
content: "Porta {{ app_port }}"

# Handlers:
## Exemplo handler
handlers:

  - name: restart nginx
    service:
      name: nginx
      state: restarted
Notify handler
notify:
  - restart nginx

## Templates
Template Jinja2
- name: Copiar template
  template:
    src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf

# Roles
## Criar role
ansible-galaxy init nginx
Estrutura role
roles/
└── nginx/
    ├── tasks/
    ├── handlers/
    ├── templates/
    ├── vars/
    └── defaults/

# Facts:
## Ver facts
ansible all -i hosts -m setup

## Ver IP hosts
ansible all -i hosts -m setup | grep ansible_default_ipv4

# SSH:
## Gerar chave SSH
ssh-keygen

## Copiar chave
ssh-copy-id vagrant@192.168.1.3

## Testar SSH
ssh vagrant@192.168.1.3


# ansible.cfg
## Exemplo
[defaults]
inventory = hosts
host_key_checking = False

# Namespaces e grupos
## Grupo APP
  [app]
  app01
  app02

## Grupo DB
  [db]
  db01
  MariaDB/MySQL

## Instalar MariaDB
  - name: Instalar MariaDB
    apt:
      name: mariadb-server
      state: present

##  Iniciar MariaDB
  - name: Iniciar MariaDB
    service:
      name: mariadb
      state: started

# Docker + Ansible:
## Instalar Docker
  - name: Instalar Docker
    apt:
      name: docker.io
      state: present


## Rodar container
  - name: Subir container nginx
    docker_container:
      name: nginx
      image: nginx
      state: started
      ports:
        - "80:80"


# Vagrant + Ansible:
## Subir VM
vagrant up

## Entrar VM
vagrant ssh

## Reiniciar VM
vagrant reload

## Reprovisionar
vagrant reload --provision

# Troubleshooting
## Verificar conectividade
ansible all -i hosts -m ping

## Ver portas abertas
ss -tulnp

## Ver IP Linux
ip a

## Ver logs serviço
journalctl -u nginx

## Ver status serviço
systemctl status nginx

# Estrutura recomendada:
  ansible-lab/
  ├── hosts
  ├── ansible.cfg
  ├── playbooks/
  │   ├── nginx.yml
  │   └── mariadb.yml
  │
  ├── roles/
  │
  ├── group_vars/
  │
  └── templates/

# Fluxo DevOps com Ansible:
  Control Node
        ↓
  SSH
        ↓
  Managed Hosts
        ↓
  Playbooks YAML
        ↓
  Automação Infraestrutura
