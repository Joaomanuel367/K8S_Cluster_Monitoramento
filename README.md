# Monitoramento Rede Dor

Projeto de monitoração para o cliente RedeDor
Inicialmente com Grafana, Zabbix e MySql.
Será composto por 4 maquinas virtuais com Kubernetes e o ambiente será criado com infraestrutura como código

# 🚀 Começando
Essas instruções permitirão que você obtenha uma cópia do projeto em operação na sua máquina local para fins de desenvolvimento e teste e manutenção.

Consulte Implantação para saber como implantar o projeto.

# 📋 Pré-requisitos
Permissão no comando sudo para o usuario que realizara a execução do Script ansible, liberação de rede para instalação de ferramentas externas e Comunicação ssh entre os servidores que serão utilziados como Cluster e Slaves

Dar exemplos

# 🔧 Implantação
Para a fase de Implantação do Ambiente, será necessario ter acesso a um servidor externo ao cluster para realizar os disparos ou se preferir poderá colocar em alguma ferramenta de Job Scheduling ou Automação inteligente, nos exemplos a seguir usaremos um servidor externo para disparos

Primeiramente execute o Script "Implatacao.sh" com um usuario com permissões sudo
De a permissão de execução no Script da seguinte forma:
    chmod +x Implatacao.sh

Após isso execute o Script "Implantacao.sh":
    /bin/bash Implatacao.sh
E aguarde

Após a implatação do ambiente ocorrer com sucesso acesse o serviço do grafana usando seu ip + porta 30000 da seguinte forma:
http://IPdoServidor:30000/login
Colocar o ip e imagem de exemplo



Até finalizar
Termine com um exemplo de como obter dados do sistema ou como usá-los para uma pequena demonstração.


# 📦 Status
Em desenvolvimento, vamos incluir o kind statefulset no mysql e também mais uma ferramenta de monitoração

# 🛠️ Construído com
Ferramentas usadas para construir projeto

Visual Studio Code 1.60 - O framework usado para construir os códigos

Ansible 2.9.25 - Linguagem usada para criação da infraestrutura como código

Kubernetes - Sistema usado para orquestração dos containers 

Docker 1.13.1 - Software Usado para criação contêineres

Grafana 8.2 - Aplicação web que fornece tabelas, gráficos e alertas para a Web

Mysql 8.0.19 - O MySQL é um sistema de gerenciamento de banco de dados, que utiliza a linguagem SQL como interface

# 📌 Versão
Para as versões disponíveis, observe as tags neste repositório.

# ✒️ Autores
Eu mesmo
