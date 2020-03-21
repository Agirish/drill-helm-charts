#!/usr/bin/env bash

kubectl create configmap drill-config-cm --from-file=drill-override.conf --from-file=drill-env.sh
