FROM centos:7

RUN yum install openssh-server -y
RUN yum install openssh-clients -y

RUN mkdir /root/.ssh
RUN touch /root/.ssh/authorized_keys
RUN chmod 700 /root/.ssh
RUN chmod 600 /root/.ssh/authorized_keys

ADD id_rsa /root/.ssh/
ADD id_rsa.pub /root/.ssh/

RUN echo "hadoop" | passwd --stdin root

#RUN chkconfig sshd on
RUN systemctl enable sshd
RUN systemctl start sshd

RUN yum -y ntp
RUN systemctl enable ntpd

RUN systemctl disable firewalld
RUN systemctl stop firewalld

RUN umask 022

ADD ambari.repo /etc/yum.repos.d/
RUN yum install ambari-agent -y
RUN yum install ambari-server -y

RUN ambari-server setup -s
