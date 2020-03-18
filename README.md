# Helm Charts to Deploy Apache Drill on Kubernetes

## Overview
Helm is a package manager for Kubernetes. And Helm Charts is a packaging format that can help with installing and managing lifecycle of Kubernetes applications such as Drill Clusters.

Drill Helm Charts is a collection of files that describe the set of resources used for Drill Clusters on Kubernetes.

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

### Install the Drill Chart
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
