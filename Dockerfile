FROM ubuntu:20.04

LABEL maintainer="thucpt@bap.jp"

LABEL version="1.0"

LABEL description="This is custom docker image for nginx service"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update

RUN apt-get install -y sudo

RUN sudo apt-get install -y openssh-server curl vim

RUN mkdir /var/run/sshd

RUN sudo apt-get install -y zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev libgdbm-dev libncurses5-dev automake libtool bison libffi-dev net-tools git nginx

RUN echo 'root:20011998' | chpasswd

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"

RUN echo "export VISIBLE=now" >> /etc/profile

RUN useradd -ms /bin/bash -p 20011998 thucpt

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
