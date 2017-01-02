#(Desconsiderar ... pendente de atualização)
#Pentaho 5 CE com PostgreSQL 9.3

Este diretório reúne todos os arquivos necessários para configuração do Pentaho CE, versão 5.0.1, com PostgreSQL 9.3. Detalhes da configuração podem ser consultados na documentação oficial, [infocenter.pentaho.com](http://infocenter.pentaho.com/)

Ambiente testado
<pre>
cat /etc/system-release
Amazon Linux AMI release 2013.09

uname -a
Linux 3.4.76-65.111.amzn1.x86_64 #1 SMP Tue Jan 14 21:06:49 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

java -version
java version "1.7.0_51"

psql --version
psql (PostgreSQL) 9.3.3
</pre>

## Arquivos de configuração

<pre>
 pentaho-server/data/postgresql/create_jcr_postgresql.sql
 pentaho-server/data/postgresql/create_quartz_postgresql.sql
 pentaho-server/data/postgresql/create_repository_postgresql.sql
 pentaho-server/pentaho-solutions/system/hibernate/hibernate-settings.xml
 pentaho-server/pentaho-solutions/system/hibernate/postgresql.hibernate.cfg.xml
 pentaho-server/pentaho-solutions/system/jackrabbit/repository.xml
 pentaho-server/pentaho-solutions/system/quartz/quartz.properties
 pentaho-server/pentaho-solutions/system/sessionStartupActions.xml
 pentaho-server/tomcat/webapps/pentaho/META-INF/context.xml
 pentaho-server/tomcat/webapps/pentaho/WEB-INF/web.xml
</pre>



##Procedimento

###Instalação do PostgreSQL Local

 * Referência: [Instalação PostgreSQL](https://wiki.postgresql.org/wiki/YUM_Installation)
 * Configuração - <code>pg_hba.conf</code>

<pre>
sudo vi /var/lib/pgsql/9.3/data/pg_hba.conf
host    all             all             0.0.0.0/0               md5
</pre>

 * Configuração do PostgreSQL - <code>postgresql.conf</code>

<pre>
sudo vim /var/lib/pgsql/9.3/data/postgresql.conf
listen_addresses = '*'
</pre>

###Aplicar configurações predefinidas

As etapas a seguir consideram que a preparação do ambiente já foi realizado. verificar [pentaho5/README.md](https://github.com/wmarinho/pentaho5/)

### Baixar repositório Git
<pre>
sudo su - pentaho
cd /opt/pentaho
git clone https://github.com/wmarinho/pentaho5.git
</pre>

###Aplicar configurações do PostgreSQL

<pre>
cp -r config/postgresql/pentaho-server .
</pre>

### Inicializar repositório

Usuários e senhas estão predefinidos nos arquivos *.sql. 
Para utilizar em produção, é recomendável a alteração em todos os arquivos. 

<pre>
cd pentaho-server/data/postgresql
</pre>

<pre>
psql -U postgres -h localhost < create_quartz_postgresql.sql
psql -U postgres -h localhost < create_repository_postgresql.sql
psql -U postgres -h localhost < create_jcr_postgresql.sql
</pre>


### Inicializar Pentaho 
<pre>
cd /opt/pentaho/pentaho-server
./start-pentaho.sh
</pre>

Caso já tenha configurado, utilize:
<pre>
service pentaho start
</pre>

