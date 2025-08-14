@REM login to OpenShift, API_TOKEN removed for discretion
oc login --token=<API_TOKEN> --server=https://api.rm3.7wse.p1.openshiftapps.com:6443

@REM --- MYSQL creation ---
oc apply -f mysql-secret.yaml -n pplevins-dev               @REM create secret
oc apply -f mysql-pvc.yaml -n pplevins-dev                  @REM create pvc
oc apply -f mysql-deployment.yaml -n pplevins-dev           @REM create deployment
oc apply -f mysql-service.yaml -n pplevins-dev              @REM create service
oc port-forward svc/mysql 3306:3306 -n pplevins-dev         @REM forwarding the mysql service to local host