FROM isuper/java-oracle:jdk_8


MAINTAINER Wellington Marinho wpmarinho@globo.com

# Init ENV
ENV BISERVER_VERSION 7.0
ENV BISERVER_TAG 7.0.0.0-25

ENV PENTAHO_HOME /opt/pentaho

# Apply JAVA_HOME
RUN . /etc/environment
ENV PENTAHO_JAVA_HOME $JAVA_HOME
ENV PENTAHO_JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Install Dependences
RUN apt-get update; apt-get -y install zip netcat less; \
    apt-get install wget unzip git postgresql-client-9.5 vim -y; \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

RUN mkdir ${PENTAHO_HOME}; useradd -s /bin/bash -d ${PENTAHO_HOME} pentaho; chown pentaho:pentaho ${PENTAHO_HOME}

USER pentaho

# Download Pentaho BI Server
RUN /usr/bin/wget --progress=dot:giga http://downloads.sourceforge.net/project/pentaho/Business%20Intelligence%20Server/${BISERVER_VERSION}/pentaho-server-ce-${BISERVER_TAG}.zip -O /tmp/pentaho-server-ce-${BISERVER_TAG}.zip; \
    /usr/bin/unzip -q /tmp/pentaho-server-ce-${BISERVER_TAG}.zip -d  $PENTAHO_HOME; \
    rm -f /tmp/pentaho-server-ce-${BISERVER_TAG}.zip $PENTAHO_HOME/pentaho-server-ce/promptuser.sh; \
    sed -i -e 's/\(exec ".*"\) start/\1 run/' $PENTAHO_HOME/pentaho-server/tomcat/bin/startup.sh; \
    chmod +x $PENTAHO_HOME/pentaho-server/start-pentaho.sh

COPY config $PENTAHO_HOME/config
COPY scripts $PENTAHO_HOME/scripts

WORKDIR /opt/pentaho 
EXPOSE 8080 
CMD ["sh", "scripts/run.sh"]
