@REM login to OpenShift, API_TOKEN removed for discretion
oc login --token=<API_TOKEN> --server=https://api.rm3.7wse.p1.openshiftapps.com:6443

@REM --- MYSQL creation ---
@REM create secret
oc apply -f mysql-secret.yaml -n pplevins-dev