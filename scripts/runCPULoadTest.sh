#!/usr/bin/env bash
set -x

namespace=default
clustername=drillcluster1
pods=$((`kubectl get pods -n $namespace |grep -i $clustername | wc -l` -1))

for i in `seq 0 $pods`
do
  kubectl exec ${clustername}-drillbit-${i} --namespace=${namespace} -- /usr/bin/stress -c 3 &
done
