# Helm Charts for Apache Drill

## Overview
This repository contains a collection of files that can be used to deploy [Apache Drill](http://drill.apache.org/) on Kubernetes using Helm Charts. Supports single-node and [cluster](http://drill.apache.org/docs/installing-drill-in-distributed-mode/) modes.

#### What are Helm and Charts?
[Helm](https://helm.sh/) is a package manager for [Kubernetes](https://kubernetes.io/). [Charts](https://helm.sh/docs/topics/charts/) are a packaging format in Helm that can simplify deploying Kubernetes applications such as Drill Clusters.

## Pre-requisites

- A Kubernetes Cluster (this project is tested on [GKE](https://cloud.google.com/kubernetes-engine/) clusters)
- [Helm](https://github.com/helm/helm#install) version 3 or greater
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) version 1.16.0 or greater

## Chart Structure
Drill Helm charts are organized as a collection of files inside of the `drill` directory. As Drill depends on Zookeeper for cluster co-ordination, a zookeeper chart is inside the [dependencies](drill/charts) directory. The Zookeeper chart follows a similar structure as the Drill chart.
```
drill/   
  Chart.yaml    # A YAML file with information about the chart
  values.yaml   # The default configuration values for this chart
  charts/       # A directory containing the ZK charts
  templates/    # A directory of templates, when combined with values, will generate valid Kubernetes manifest files
  ```
## Usage

### Templates
Helm Charts contain `templates` which are used to generate Kubernetes manifest files. These are YAML-formatted resource descriptions that Kubernetes can understand. These templates contain 'variables', values for which  are picked up from the `values.yaml` file.

Drill Helm Charts contain the following templates:
```
drill/
  ...
  templates/
    drill-rbac-*.yaml       # To enable RBAC for the Drill app
    drill-service.yaml      # To create a Drill Service
    drill-web-service.yaml  # To expose Drill's Web UI externally using a LoadBalancer. Works on cloud deployments only. 
    drill-statefulset.yaml  # To create a Drill cluster
  charts/
    zookeeper/
      ...
      templates/
        zk-rbac.yaml        # To enable RBAC for the ZK app
        zk-service.yaml     # To create a ZK Service
        zk-statefulset.yaml # To create a ZK cluster. Currently only a single-node ZK (1 replica) is supported
```

### Values
Helm Charts use `values.yaml` for providing default values to 'variables' used in the chart templates. These values may be overridden either by editing the `values.yaml` file or during `helm install`. For example, such as the namespace, number of drillbits and more to the `template` files

Drill Helm Charts contain the following default values:
```
repo: hub.docker.com/u/           # Drill Image repository

global:
  namespace: default              # Provide the NAMESPACE_NAME value here

drill:
  id: drill                       # Drill Cluster Name
  count: 1                        # Number of drill-bits per Drill Cluster
  memory: 5Gi                     # Memory for each drill pod (in Gigibytes - Gi)
  cpu: 500m                       # CPU for each drill pod (in milli-cpus)
  image: agirish/drill:1.17.0     # Drill image name with tag

zookeeper:
  id: zk                          # Zookeeper Name
  memory: 2Gi                     # Memory for each ZK pod (in Gigibytes - Gi)
  cpu: 500m                       # CPU for each ZK pod (in milli-cpus)
  image: agirish/zookeeper:3.6.0  # Zookeeper image name with tag
```

### Install
Drill Helm Charts can be installed using the following command: 
```
# helm install <UNIQUE_NAME> drill/
helm install drill1 drill/
```
Kubernetes [Namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) can be used when more that one Drill Cluster needs to be created. We use the `default` namespace by default. To create a namespace, use the following command:
```
# kubectl create namespace <NAMESPACE_NAME>
kubectl create namespace namespace1
```
This NAMESPACE_NAME needs to be provided in `drill/values.yaml`. Or can be provided in the `helm install` command as follows:
```
# helm install <UNIQUE_NAME> drill/ --set global.namespace=<NAMESPACE_NAME>
helm install drill1 drill/ --set global.namespace=namespace1
helm install drill2 drill/ --set global.namespace=namespace2
```
Note that installing the Drill Helm Chart also installs the dependent Zookeeper chart. So with current design, for each instance of a Drill cluster includes a single-node Zookeeper.

### Uninstall
Drill Helm Charts can be uninstalled using the following command: 
```
# helm [uninstall|delete] --purge <UNIQUE_NAME_USED_ABOVE>
helm delete --purge drill1
helm delete --purge drill2
```
