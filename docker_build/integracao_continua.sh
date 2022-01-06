#!/bin/bash

#Configuração das variaveis
#./configvars.sh 

#Criação dos usuarios
ansible-playbook -i ./Ansible/hosts ./Ansible/initial.yml

#Instalação dos componentes
ansible-playbook -i ./Ansible/hosts ./Ansible/dependencies.yml

#Git clones dos artefatos para o servidor master
echo -e "\n Git Clones \n"
chmod 0600 ./Ansible/.asda   
ansible-playbook -i ./Ansible/hosts ./Ansible/git-config.yml --vault-password-file ./Ansible/.asda

#Iniciando a montagem dos discos onde ficarão armazenados o conteudo dos volumes persistentes
echo -e "\n Iniciando Montagem dos NFS \n"
ansible-playbook -i ./Ansible/hosts ./Ansible/mount-disks.yml

#Aqui estamos iniciando o cluster do kubernetes
echo -e "\n Iniciando Cluster Kubernetes \n"
ansible-playbook -i ./Ansible/hosts ./Ansible/master.yml

#Aqui estamos vinculando os nodes ao cluster do kubernetes
echo -e "\n Plugando nodes Kubernetes \n"
ansible-playbook -i ./Ansible/hosts ./Ansible/workers.yml

#Aqui iniciamos a implantação e configuração do MySql na versão 8.0 LTS
echo -e "\n Instalando Mysql \n"
ansible-playbook -i ./Ansible/hosts ./Ansible/deploy-mysql.yml

#Aqui iniciamos a implantação e configuração do Grafana
echo -e "\n Instalando o Grafana nos nodes \n"
ansible-playbook -i ./Ansible/hosts ./Ansible/deploy-grafana.yml

#Aqui iniciamos a implantação e configuração do Zabbix
echo -e "\n Instalando o Zabbix nos nodes \n"
ansible-playbook -i ./Ansible/hosts ./Ansible/deploy-zabbix.yml

#Aqui iniciamos a implantação do ingress-controller
echo -e "\n Instalando o Ingress-controller nos nodes \n"
ansible-playbook -i ./Ansible/hosts ./Ansible/deploy-ingress.yml


#Aqui iniciamos a implantação e configuração do servidor de metrics e do HPA responsavel pelo auto escalonamento dos #pods
echo -e "\n Configurando Autoscaler \n"
ansible-playbook -i  ./Ansible/hosts ./Ansible/deploy-autoscaling.yml
echo "# ============ Ambiente implantado ============#"
