FROM centos:centos7.9.2009
USER root
COPY ./id_rsa /root/.ssh/
COPY ./authorized_keys /home/Ansible/.ssh/id_rsa.pub

RUN yum -y groupinstall "Development Tools" \
    && yum -y install wget openssl-devel bzip2-devel libffi-devel xz-devel gettext-devel perl-CPAN perl-devel zlib-devel -y \
    && yum install centos-release-ansible-29 -y \
    && yum install ansible -y \
    && yum clean all
RUN chmod 400 /root/.ssh/id_rsa && for i in $(echo 20.119.193.135 20.114.208.90 20.119.232.161 20.114.136.38);do ssh-keyscan $i >> $HOME/.ssh/known_hosts;done
ENV TZ=America/Sao_Paulo