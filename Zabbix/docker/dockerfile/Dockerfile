FROM zabbix/zabbix-server-mysql:centos-5.0.0
USER root
RUN mkdir -p /usr/lib/oracle/12.2/client64/lib/ /usr/lib/oracle/12.2/client64/network/admin /tmp/bins
COPY oracle /usr/lib/oracle/12.2/client64/lib/
COPY mysql /tmp/bins
COPY sqlserver /tmp/bins
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
RUN rpm -i /usr/lib/oracle/12.2/client64/lib/libaio-0.3.109-13.el7.x86_64.rpm && \
    rpm -i /tmp/bins/make-3.82-24.el7.x86_64.rpm && \
    rpm -i /tmp/bins/openssl-1.0.2k-19.el7.x86_64.rpm && \
    ACCEPT_EULA=Y yum install /tmp/bins/msodbcsql17-17.8.1.1-1.x86_64.rpm -y && \
    ACCEPT_EULA=Y yum install /tmp/bins/mssql-tools-17.8.1.1-1.x86_64.rpm -y && \
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc && \
    tar -vzxf /tmp/bins/mariadb-connector-odbc-3.1.13-centos7-amd64.tar.gz -C /tmp/bins/ && \
    cd /tmp/bins/mariadb-connector-odbc-3.1.13-centos7-amd64/ && \
    rpm -i /tmp/bins/mysql-connector-odbc-8.0.19-1.el7.x86_64.rpm && \
    install lib64/mariadb/libmaodbc.so /usr/lib/ && \
    install -d /usr/lib/mariadb/ && \
    install -d /usr/lib/mariadb/plugin/ && \
    install lib64/mariadb/plugin/auth_gssapi_client.so /usr/lib/mariadb/plugin/ && \
    install lib64/mariadb/plugin/caching_sha2_password.so /usr/lib/mariadb/plugin/ && \
    install lib64/mariadb/plugin/client_ed25519.so /usr/lib/mariadb/plugin/ && \
    install lib64/mariadb/plugin/dialog.so /usr/lib/mariadb/plugin/ && \
    install lib64/mariadb/plugin/mysql_clear_password.so /usr/lib/mariadb/plugin/ && \
    install lib64/mariadb/plugin/sha256_password.so /usr/lib/mariadb/plugin/ && \
    source ~/.bashrc && \
    rm -rf /tmp/bins
    

ENV ORACLE_BASE /usr/lib/oracle/12.2/client64/lib
ENV LD_LIBRARY_PATH /usr/lib/oracle/12.2/client64/lib
ENV TNS_ADMIN /usr/lib/oracle/12.2/client64/network/admin
ENV ORACLE_HOME /usr/lib/oracle/12.2/client64/lib
