FROM centos:7.8.2003

# 更新版本1
MAINTAINER runcare<larrygui@foxmail.com>

ARG JDK_VERSION="jdk-8u251-linux-x64.tar.gz"
ARG MVN_VERSION="3.6.3"
#ENV	JDK_DOWNLOAD_URL  http://cdn01.qikesh.com/jdk/$JDK_VERSION ##备用下载地址
ENV	JDK_DOWNLOAD_URL  https://darensh.oss-cn-shanghai.aliyuncs.com/jdk/$JDK_VERSION
ENV	MVN_DOWNLOAD_URL  https://mirror.bit.edu.cn/apache/maven/maven-3/$MVN_VERSION/binaries/apache-maven-$MVN_VERSION-bin.tar.gz

RUN mkdir -p /tmp/dependencies  \
    mkdir -p /usr/local/java  \
	mkdir -p /usr/local/mvn  \
	&& curl -L --silent $JDK_DOWNLOAD_URL >  /tmp/dependencies/$JDK_VERSION  \
	&& tar -xzf /tmp/dependencies/$JDK_VERSION -C /usr/local/java  \
	&& curl -L --silent $MVN_DOWNLOAD_URL >  /tmp/dependencies/apache-maven-$MVN_VERSION-bin.tar.gz  \
	&& tar -xzf /tmp/dependencies/apache-maven-$MVN_VERSION-bin.tar.gz -C /usr/local/mvn  \
	&& rm -rf /tmp/dependencies \
	&& yum install -y git


#如果修改JRE_VERSION中的版本号，需要对应修改JAVA_HOME路径中的版本
ENV JAVA_HOME /usr/local/java/jdk1.8.0_251
ENV MAVEN_HOME /usr/local/mvn
ENV PATH $PATH:$JAVA_HOME/bin:$MAVEN_HOME
#设置时区为上海
ENV TZ Asia/Shanghai

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone