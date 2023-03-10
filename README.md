# terraform-digitalocean

Jornada DevOps de Elite - Aula 03:
Este repositório é parte da atividade pratica da Aula 03 do Curso Jornada DevOps de Elite , ocorrido de 23 de Janeiro a 29 de Janeiro de 2023, promovido pela [Devops Pro](https://www.devopspro.com.br/jornada-de-elite).


## Requisitos do Projeto:

Antes de começar, você vai precisar ter instalado em sua máquina os seguintes recursos:

- [Git](https://git-scm.com/downloads)
- [Docker](https://docs.docker.com/get-docker/)
- [K3d](https://k3d.io/v5.4.6/#installation)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Terraform](https://developer.hashicorp.com/terraform/downloads?product_intent=terraform)
- [DigitalOcean](https://cloud.digitalocean.com)

## Executando o Projeto:

Para testarmos a aplicação, temos que executar os N passos a seguir:

1. [Fazer download do Projeto](#download-github)
2. [Criar e adicionar chave ssh na DigitalOcean](#criar-ssh)
3. [Criar Token na DigitalOcean](#criar-token)
4. [Iniciar o Provisionamento da Infraestrutura](#iniciar-infra)
5. [Instalação do Jenkins](#instalar-jenkins)


<a name="download-github"></a>
### 1. Fazer downloa do do Projeto:
 1. Baixe este Repositório, executando o comando Git:
```bash
git clone https://github.com/leandroph/terraform-digitalocean.git
```
<a name="criar-ssh"></a>
### 2. Criar e adicionar chave ssh na DigitalOcean:

 1. Criar uma conta na [DigitalOcean](https://cloud.digitalocean.com).
 
 2. Criar uma chave ssh, no terminal digite o comando:
 ```bash
 ssh-keygen -t rsa -b 2048
 ```
 - <b>Obs.:</b> Você terá uma resposta semelhante ao texto abaixo:
 ```bash
 Generating public/private rsa key pair.
 Enter file in which to save the key (/home/<username>/.ssh/id_rsa):
 ```
 3. Na saída apresentada acima informe o diretório onde a chave ssh ficara salva, não utilizar o mesmo nome da chave id_rsa, para não ter problemas caso já utilize essa chave para outros projetos, segue o exemplo:
 ```bash
 /home/<username>/.ssh/terraform
 ```
 
 4. Pegar a chave pública:
 ```bash
 /cat /home/<username>/.ssh/terraform.pub
 ```
 
 5. Adicionar a chave pública na DigitalOcean:
 
   - Settings -> Security -> Add SSH key
 
<a name="criar-token"></a>
### 3. Criar Token na DigitalOcean:

 1. Criar o Token [DigitalOcean](https://cloud.digitalocean.com):
 - API -> Generate New Token
 
 2. Copiar o Token e adiciona-lo na variavável do_token que está no arquivo `terraform.tfvars`.
 
<a name="iniciar-infra"></a>
### 4. Iniciar o Provisionamento da Infraestrutura]:
 1. Iniciar o terraform, com o comando:
  ```bash
  terraform init
  ```
 2. Dar o Apply do projeto:
  ```bash
  terraform apply
  ```
  - <b>Obs.:</b> Você terá uma resposta semelhante ao texto abaixo:
  ```bash
  Outputs:

  jenkins_ip = "206.189.186.55"
  ```
  Após a Apply a Infraestrutura já está criada na DigitalOcean, onde foi criada uma máquina virtual e um cluster Kubernetes.
  
  3. Conectar na VM criada, utilize o IP informado na saída anterior:
  ```bash
  ssh -i /home/leandro/.ssh/terraform root@<your ip>
  ```
  
  4. Copiar o arquivo `kube_config.yaml`, para o diretório `.kube`:
  ```bash
  cp kube_config.yaml /home/<username>/.kube/config
  ```
  Após a cópia do arquivo .yaml, verifique os nodes do cluster kubernetes:
  ```bash
  kubectl get nodes
  ```
  
  - <b>Obs.:</b> Você terá uma resposta semelhante ao texto abaixo:
  ```bash
  NAME            STATUS   ROLES    AGE   VERSION
  default-m9zf7   Ready    <none>   33m   v1.25.4
  default-m9zfm   Ready    <none>   33m   v1.25.4
  ```
  
<a name="instalar-jenkins"></a>
### 5. Instalação do Jenkins:
 1. Caso não estiver conectado na VM, é preciso conectar na máquina criada, utilize o IP informado na saída anterior:
  ```bash
  ssh -i /home/leandro/.ssh/terraform root@<your ip>
  ```
  
 2. Realizar o update do sistema e instação do Java JDK, pois o [Jenkins](https://www.jenkins.io/doc/book/installing/linux/) necessita que o Java esteja instalado na VM:
 ```bash
 apt update
 apt install openjdk-17-jdk -y
 ```
 
 3. Realizar a instalação do [Jenkins](https://www.jenkins.io/):
 ```bash
  curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
 ```
 
 4. Instalar o [Docker](https://docs.docker.com/engine/install/ubuntu/) e adicionar o usuário jenkins ao grupo do Docker:
 ```bash
 usermod -aG docker jenkins
 ```
 Reiniciar o Jenkins:
 ```bash
 systemctl restart jenkins
 ```
 5. instalar o [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/).
 
 6. Acessar o Jenkins no navegador `<IP_máquina>:8080`, e seguir com as configurações finais.
 
 7. Será preciso instalar alguns plugins do Docker e Kubernetes, ir em Gerenciar Jenkins -> Gerenciar extensões -> Extensões Disponíveis, e instalar as seguintes extenções:
 - Docker
 - Docker Pipeline
 - Kubernetes CLI
 

 
 
