FROM centos:7

ARG VERSION
RUN echo $VERSION
ARG MIRROR=https://downloads.apache.org/zookeeper
RUN echo $MIRROR

# Install Pre-Requisite Packages
RUN yum install -y java-1.8.0-openjdk-devel vim; yum clean all ; rm -rf /var/cache/yum

# Configure User Login
RUN echo 'root:drill' | chpasswd

# Install ZooKeeper
ADD $MIRROR/zookeeper-$VERSION/apache-zookeeper-${VERSION}-bin.tar.gz /tmp/
RUN mkdir /opt/zookeeper
RUN tar -xzf /tmp/apache-zookeeper-${VERSION}-bin.tar.gz --directory=/opt/zookeeper --strip-components 1
RUN rm -f /tmp/apache-zookeeper-${VERSION}-bin.tar.gz

# Configure ZooKeeper
RUN printf "tickTime=2000\ndataDir=/var/lib/zookeeper\nclientPort=2181" > /opt/zookeeper/conf/zoo.cfg

# Start ZooKeeper
COPY start.sh /usr/bin/start.sh
ENTRYPOINT /usr/bin/start.sh
