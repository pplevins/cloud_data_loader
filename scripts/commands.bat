@REM login to OpenShift, API_TOKEN removed for discretion
oc login --token=<API_TOKEN> --server=https://api.rm3.7wse.p1.openshiftapps.com:6443

@REM --- MYSQL creation ---
oc apply -f mysql-secret.yaml -n pplevins-dev               @REM create secret
oc apply -f mysql-pvc.yaml -n pplevins-dev                  @REM create pvc
oc apply -f mysql-deployment.yaml -n pplevins-dev           @REM create deployment
oc apply -f mysql-service.yaml -n pplevins-dev              @REM create service
oc port-forward svc/mysql 3306:3306 -n pplevins-dev         @REM forwarding the mysql service to local host

@REM --- Building the application ---
docker build -t pplevins/cloud_data_loader:v1.0 .
docker push pplevins/cloud_data_loader:v1.0

@REM --- Creating database in the mysql pod ---
oc cp dat/insert_data.sql mysql-8489dbcf89-zhv5c:/tmp/insert_data.sql -n pplevins-dev
oc cp dat/create_data.sql mysql-8489dbcf89-zhv5c:/tmp/create_data.sql -n pplevins-dev
oc exec -it svc/mysql -n pplevins-dev -- bash
mysql -u root -p"1234" < tmp/create_data.sql
mysql -u root -p"1234" < tmp/insert_data.sql

@REM --- Creating the data loader on the OpenShift cloud ---
oc apply -f loader-deployment.yaml -n pplevins-dev
oc apply -f loader-service.yaml -n pplevins-dev
oc expose svc/data_loader -n pplevins-dev