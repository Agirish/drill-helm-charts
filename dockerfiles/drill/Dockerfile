FROM centos:7

ARG VERSION
RUN echo $VERSION
ARG MIRROR=http://www.apache.org/dyn/closer.lua?filename=drill
RUN echo $MIRROR

EXPOSE 8047 31010 31011 31012

# Install Pre-Requisite Packages
RUN yum install -y java-1.8.0-openjdk-devel vim which; yum clean all ; rm -rf /var/cache/yum

# Configure User Login
RUN echo 'root:drill' | chpasswd

# Install Drill
ADD "$MIRROR/drill-$VERSION/apache-drill-$VERSION.tar.gz&action=download" /tmp/apache-drill-$VERSION.tar.gz
RUN mkdir /opt/drill
RUN tar -xzf /tmp/apache-drill-$VERSION.tar.gz --directory=/opt/drill --strip-components 1
RUN rm -f /tmp/apache-drill-$VERSION.tar.gz

# Test Drill
RUN echo "select * from sys.version;" > /tmp/version.sql
RUN /opt/drill/bin/sqlline -u jdbc:drill:zk=local --run=/tmp/version.sql

# Copy Scripts
COPY distrib-env.sh drill-distrib.conf /opt/drill/conf/
COPY start.sh /usr/bin/start.sh

# Start Drill
ENTRYPOINT /usr/bin/start.sh
