# Helm Charts for Apache Drill

## Overview
This repository contains a collection of files that can be used to deploy [Apache Drill](http://drill.apache.org/) on Kubernetes using Helm Charts. Supports single-node and [cluster](http://drill.apache.org/docs/installing-drill-in-distributed-mode/) modes.

#### What are Helm and Charts?
[Helm](https://helm.sh/) is a package manager for [Kubernetes](https://kubernetes.io/). [Charts](https://helm.sh/docs/topics/charts/) is a packaging format in Helm that can simplify deploying Kubernetes applications such as Drill Clusters.

## Pre-requisites

- Kubernetes Cluster. Drill Helm Charts are tested on [GKE](https://cloud.google.com/kubernetes-engine/)
- [Helm](https://github.com/helm/helm#install) version 3.x or greater.
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) version 1.16.x or greater.

## Structure
```
drill/   
  Chart.yaml    # A YAML file with information about the chart
  values.yaml   # The default configuration values for this chart
  charts/       # A directory containing the ZK charts
  templates/    # A directory of templates, when combined with values, will generate valid Kubernetes manifest files
  ```
## Usage

### Edit values.yaml
Helm Charts use `values.yaml` for providing values such as the namespace, number of drillbits and more to the `template` files

Sample [values.yaml](drill/values.yaml)

```
repo: hub.docker.com/r/         # Drill Image repository
namespace: default              # Provide the NAMESPACE_NAME value here
drill:
  id: drill                     # Drill Cluster Name
  count: 1                      # Number of drill-bits per Drill Cluster
  memory: 5Gi                   # Total memory for each drill-bit (sum total of the below 3 fields)
  direct_memory: 3G             # Direct memory for each drill-bit
  heap_memory: 1G               # Heap memory for each drill-bit
  code_cache_memory: 512M       # Code Cache memory for each drill-bit 
  cpu: 500m                     # CPU for each drill-bit (in milli-cpus)
  image: agirish/drill:1.14.0   # Drill image name with tag
```

### Deploy Drill on Kubernetes
```
# helm install <UNIQUE_NAME> drill/
helm install drill1 drill/

```

Kubernetes [Namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) can be used when more that one Drill Cluster needs to be created. We use the `default` namespace, so this step can be skipped if only one cluster is planned.
```
# kubectl create namespace <NAMESPACE_NAME>
kubectl create namespace namespace1
```
This NAMESPACE_NAME needs to be provided in `drill/values.yaml`. Or can be provided in the helm install command as follows:
```
# helm install <UNIQUE_NAME> drill/ --set global.namespace=<NAMESPACE_NAME>
helm install drill1 drill/ --set global.namespace=namespace1
```
