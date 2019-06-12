FROM openjdk:8-stretch

MAINTAINER Bertrand RETIF bertrand@sudokeys.com

# Init ENV
ENV BISERVER_VERSION 8.2
ENV BISERVER_TAG 8.2.0.0-342

ENV PENTAHO_HOME /opt/pentaho

# Apply JAVA_HOME
RUN . /etc/environment
ENV JAVA_HOME /usr/local/openjdk-8
ENV PENTAHO_JAVA_HOME $JAVA_HOME

# Install Dependences
RUN apt-get update; apt-get -y install zip netcat less; \
    apt-get install wget unzip git postgresql-client vim -y; \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

RUN mkdir ${PENTAHO_HOME}; useradd -s /bin/bash -d ${PENTAHO_HOME} pentaho; chown pentaho:pentaho ${PENTAHO_HOME}

USER pentaho

# Download Pentaho BI Server
RUN /usr/bin/wget --progress=dot:giga http://downloads.sourceforge.net/project/pentaho/Pentaho%20${BISERVER_VERSION}/server/pentaho-server-ce-${BISERVER_TAG}.zip -O /tmp/pentaho-server-ce-${BISERVER_TAG}.zip; \
    /usr/bin/unzip -q /tmp/pentaho-server-ce-${BISERVER_TAG}.zip -d  $PENTAHO_HOME; \
    rm -f /tmp/pentaho-server-ce-${BISERVER_TAG}.zip $PENTAHO_HOME/pentaho-server/promptuser.sh; \
    sed -i -e 's/\(exec ".*"\) start/\1 run/' $PENTAHO_HOME/pentaho-server/tomcat/bin/startup.sh; \
    chmod +x $PENTAHO_HOME/pentaho-server/start-pentaho.sh

COPY config $PENTAHO_HOME/config
COPY scripts $PENTAHO_HOME/scripts

WORKDIR /opt/pentaho 
EXPOSE 8080 

USER root

ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

USER pentaho
ENTRYPOINT ["/tini", "--"]


CMD ["sh", "scripts/run.sh"]
