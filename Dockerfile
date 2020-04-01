ARG version=4.3-1
#FROM jenkins/slave:$version
FROM golang:1.13

ARG version
MAINTAINER lvelvis<liukui@ztgame.com>
LABEL Description="golang-1.13 with jnlp-slave" Vendor="jnlp-slave" Version="$version"

ARG user=root

USER root
RUN useradd jenkins &&\ 
    mkdir -p /home/jenkins/agent &&\ 
    chown -R jenkins.jenkins /home/jenkins &&\
    mkdir /go/pkg &&\
    chmod -R 777 /go

ENV GOARCH amd64
ENV GOOS linux
ENV GOPROXY https://goproxy.io

ENV PATH /usr/local/openjdk-8/bin:$PATH
ENV JAVA_VERSION 8u242
ENV AGENT_WORKDIR /home/jenkins/agent
ENV JAVA_HOME /usr/local/openjdk-8


ADD openjdk-8 /usr/local/openjdk-8
COPY jenkins-agent /usr/local/bin/jenkins-agent
RUN chmod +x /usr/local/bin/jenkins-agent &&\
    ln -s /usr/local/bin/jenkins-agent /usr/local/bin/jenkins-slave
USER ${user}

ENTRYPOINT ["jenkins-agent"]
