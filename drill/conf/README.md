## Override Drill Configuration files

Overridding the following two Drill configuration files is currently supported:
- `drill/conf/drill-env.sh`
- `drill/conf/drill-override.conf`
Please edit/replace them as needed. Please do NOT rename/delete.

Once the above configuration files are ready, please create the `drill-config-cm` configMap to upload them to Kubernetes. When a Drill chart is deployed, the files contained within this configMap will be downloaded to each container and used by the drill-bit process during start-up.
```
./createCM.sh
```
or
```
kubectl create configmap drill-config-cm --from-file=drill-override.conf --from-file=drill-env.sh
```
