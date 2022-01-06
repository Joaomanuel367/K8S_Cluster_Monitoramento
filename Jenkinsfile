pipeline {
    agent { docker { image 'docker:stable' } }
    stages {
       stage('Build') {
          environment {
                CI_CONFIG_JSON = credentials('CI_CONFIG_JSON')
                CI_DAEMON_JSON = credentials('CI_DAEMON_JSON')
                CI_REGISTRY_PASSWORD = credentials('CI_REGISTRY_PASSWORD')
                CI_SSH_PRIVATE_KEY = credentials('CI_SSH_PRIVATE_KEY')
                CI_SSH_AUTHORIZED_KEY = credentials('CI_SSH_AUTHORIZED_KEY')
            } 
          steps {
               sh "date"
               sh "apk add --update coreutils"
               sh "mkdir -p ~/.docker/ /etc/docker/"
               sh "echo $CI_CONFIG_JSON |base64 -i --decode > ~/.docker/config.json"
               sh "echo $CI_DAEMON_JSON |base64 -i --decode > /etc/docker/daemon.json"
               sh "docker info"
               sh "cat \"$CI_SSH_PRIVATE_KEY\" > docker_build/id_rsa"
               sh "cat \"$CI_SSH_AUTHORIZED_KEY\" > docker_build/authorized_keys"
               sh "docker build -t $NEXUS_URL/image-ansible:1.0 ./docker_build/"
               sh "docker push $NEXUS_URL/image-ansible:1.0"
          }
       }
       stage('Deployment') {
          environment {
                CI_CONFIG_JSON = credentials('CI_CONFIG_JSON')
                CI_REGISTRY_PASSWORD = credentials('CI_REGISTRY_PASSWORD')
                CI_SSH_PRIVATE_KEY = credentials('CI_SSH_PRIVATE_KEY')
                CI_SSH_AUTHORIZED_KEY = credentials('CI_SSH_AUTHORIZED_KEY')
                dockernexus = credentials('dockernexus')
            }
           agent {
               docker {
                    image 'nexus3.umaneplatform.com:8083/image-ansible:1.0' 
                    alwaysPull true
                    registryCredentialsId 'dockernexus'
                    registryUrl 'http://nexus3.umaneplatform.com:8083'
                    }
           }
           steps {
               sh "date"
               sh "chmod +x docker_build/integracao_continua.sh"
               sh "docker_build/integracao_continua.sh"
           }
       }
    }
 }