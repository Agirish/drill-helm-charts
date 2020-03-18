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
