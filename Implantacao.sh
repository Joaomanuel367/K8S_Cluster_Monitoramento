#!/bin/bash
gituserenc=anZpbGFuaXI=
gittokenenc=Z2tDa0pRcWhIeFBtcnhUSFlvVm8=

#Realizando o update e updagrade dos pacotes
echo "Update"
sudo yum update -y &&  yum upgrade -y

#Aqui está sendo feita a instalação do Grupo Development Tools onde ficam as ferramentas de desenvolvedores 
echo "Install Group Development Tool"
sudo yum -y groupinstall "Development Tools"
#Instalação de algumas dependecias do ansible e git
echo "Install dependencias"
sudo yum -y install wget openssl-devel bzip2-devel libffi-devel xz-devel gettext-devel perl-CPAN perl-devel zlib-devel -y

#Instalação do Ansible 2.9.25
version=$(ansible --version)
if [[ $? -gt 0 ]]
then
    echo "Instalando ansible"
    yum install centos-release-ansible-29 -y
    yum install ansible -y
else
    echo "Já possui o ansible Instalado"
fi
#Instalação do Git 2.33.0
version=$(git --version 2>&1)
if [[ $? -gt 0 ]]
then
    echo "Instalando Git"
    wget https://codeload.github.com/git/git/tar.gz/refs/tags/v2.33.0 -O git.tar.gz
    echo "Install Git"
    sudo tar xvf git.tar.gz
    cd git-*
    sudo make configure
    sudo ./configure --enable-optimizations
    sudo make install
    cd && sudo rm -rf git*
else
    echo "Já possui o ansible Instalado"
fi

#Aqui estamos decodificando o usuario git e o token do mesmo
gituser=$(echo "$gituserenc" | openssl enc -d -base64)
gittoken=$(echo "$gittokenenc" | openssl enc -d -base64)

#Criação dos diretorios necessarios para os disparos do ansible
echo -e "\n ===== Dependencias Instaladas ===== \n\n ===== Iniciando Git Clone ===== \n"
echo "Criando kube-disparos"
mkdir  $HOME/kube-disparos
cd  $HOME/kube-disparos

#Aqui estamos fazendo o clone do repositorio onde tem os artefatos para o diretorio kube-disparos e realizando a #mudança de permissoes
sudo git clone https://$gituser:$gittoken@umane.everis.com/git/REDEDOR/laboratorio-grafana.git
sudo chown -R ansible:ansible  $HOME/kube-disparos

#Primeiro disparo do ansible é para concluir as depedencias para uso do ansible e kubernetes
echo -e "\n Iniciando configuração de dependencias Ansible \n"
cd $HOME/kube-disparos/laboratorio-grafana/Ansible

#Criação dos usuarios
ansible-playbook -i hosts initial.yml

#Instalação dos componentes
ansible-playbook -i hosts dependencies.yml

#Git clones dos artefatos para o servidor master
echo -e "\n Git Clones \n"
sudo chmod 0600 .asda   
ansible-playbook -i hosts git-config.yml --vault-password-file .asda

#Iniciando a montagem dos discos onde ficarão armazenados o conteudo dos volumes persistentes
echo -e "\n Iniciando Montagem dos NFS \n"
ansible-playbook -i hosts mount-disks.yml

#Aqui estamos iniciando o cluster do kubernetes
echo -e "\n Iniciando Cluster Kubernetes \n"
ansible-playbook -i hosts master.yml

#Aqui estamos vinculando os nodes ao cluster do kubernetes
echo -e "\n Plugando nodes Kubernetes \n"
ansible-playbook -i hosts workers.yml

#Aqui iniciamos a implantação e configuração do MySql na versão 8.0 LTS
echo -e "\n Instalando Mysql \n"
ansible-playbook -i hosts deploy-mysql.yml

#Aqui iniciamos a implantação e configuração do Grafana
echo -e "\n Instalando o Grafana nos nodes \n"
ansible-playbook -i hosts deploy-grafana.yml

#Aqui iniciamos a implantação e configuração do Zabbix
echo -e "\n Instalando o Zabbix nos nodes \n"
ansible-playbook -i hosts deploy-zabbix.yml

#Aqui iniciamos a implantação e configuração do servidor de metrics e do HPA responsavel pelo auto escalonamento dos #pods
echo -e "\n Configurando Autoscaler \n"
ansible-playbook -i  hosts deploy-autoscaling.yml
echo "# ============ Ambiente implantado ============#"
