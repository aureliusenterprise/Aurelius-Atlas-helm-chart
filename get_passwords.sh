#!/bin/bash

# to get the password to keycloak admin user:
echo "keycloak admin user pwd: "
kubectl get secret keycloak-secret -o=jsonpath='{.data.password}' -n ${1} | base64 --decode; echo
echo "----"
# get keycloak passwords for the default  users of Atlas
echo "keycloak Atlas admin user pwd: "
kubectl get secret keycloak-secret-user-admin -o=jsonpath='{.data.password}' -n ${1} | base64 --decode; echo
echo "----"
echo "keycloak Atlas data steward user pwd: "
kubectl get secret keycloak-secret-user-steward -o=jsonpath='{.data.password}' -n ${1} | base64 --decode; echo
echo "----"
echo "keycloak Atlas data user pwd: "
kubectl get secret keycloak-secret-user-data -o=jsonpath='{.data.password}' -n ${1} | base64 --decode; echo
echo "=========="
# to get the password to elastic user:
echo "elasticsearch elastic user pwd: "
kubectl get secret elastic-search-es-elastic-user -o=jsonpath='{.data.elastic}' -n ${1} | base64 --decode; echo
echo "----"
