## Building Docker Images
The dockerfiles directory contains everything required to build and customize Docker images for Apache Drill and Apache ZooKeeper.

Docker images are available on [Docker Hub](https://hub.docker.com/u/agirish/). 

### Build ZooKeeper
Takes in 1 parameters: project version

Example:
```
cd dockerfiles/zookeeper
./build.sh 3.6.0
```

### Build Drill
Takes in 1 parameters: project version 

Example:
```
cd dockerfiles/drill
./build.sh 1.17.0
```
