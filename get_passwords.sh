#!/bin/bash

# to get the password to keycloak admin user:
echo "keycloak admin user pwd: "
echo "username: admin"
kubectl get secret keycloak-secret -o=jsonpath='{.data.password}' -n ${1} | base64 --decode; echo
echo "----"
# get keycloak passwords for the default  users of Atlas
echo "keycloak Atlas admin user pwd: "
echo "username: atlas"
kubectl get secret keycloak-secret-user-admin -o=jsonpath='{.data.password}' -n ${1} | base64 --decode; echo
echo "----"
echo "keycloak Atlas data steward user pwd: "
echo "username: steward"
kubectl get secret keycloak-secret-user-steward -o=jsonpath='{.data.password}' -n ${1} | base64 --decode; echo
echo "----"
echo "keycloak Atlas data user pwd: "
echo "username: scientist"
kubectl get secret keycloak-secret-user-data -o=jsonpath='{.data.password}' -n ${1} | base64 --decode; echo
echo "=========="
# to get the password to elastic user:
echo "elasticsearch elastic user pwd: "
echo "username: elastic"
kubectl get secret elastic-search-es-elastic-user -o=jsonpath='{.data.elastic}' -n ${1} | base64 --decode; echo
echo "----"
# export ATLAS_APP_SEARCH_TOKEN=$( curl -X GET "${ENTERPRISE_SEARCH_INTERNAL_URL}api/as/v1/credentials/search-key" \
#     -H 'Content-Type: application/json' --insecure \
#     -u $ELASTIC_USERNAME:$ELASTIC_PASSWORD | jq '.key' | sed 's/^"\(.*\)"$/\1/' )
echo "print app search public API token $ENTERPRISE_SEARCH_INTERNAL_URL should be public token!"
