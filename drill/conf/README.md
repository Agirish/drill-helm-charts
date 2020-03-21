## Drill Configuration files

### Supported files
This project currently supports overridding the following two configuration files"
- drill-env.sh
- drill-override.conf
Please edit them / replace them as needed. Please do NOT rename. Please do NOT delete.

### Create ConfigMap
Once the above configuration files are ready, please create a config map to upload them to Kubernetes
```
./createCM.sh
```
or
```
kubectl create configmap drill-config-cm --from-file=drill-override.conf --from-file=drill-env.sh
```
