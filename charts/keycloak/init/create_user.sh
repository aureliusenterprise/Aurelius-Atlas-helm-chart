#!/bin/bash

/opt/jboss/keycloak/bin/kcadm.sh config credentials --server http://localhost:8080/auth --realm master --user admin --password $KEYCLOAK_PASSWORD
/opt/jboss/keycloak/bin/kcadm.sh create users -r m4i -s username=$1 -s enabled=true
/opt/jboss/keycloak/bin/kcadm.sh add-roles -r m4i --uusername $1 --rolename ATLAS_USER
/opt/jboss/keycloak/bin/kcadm.sh add-roles -r m4i --uusername $1 --rolename $3
/opt/jboss/keycloak/bin/kcadm.sh set-password -r m4i --username $1 --new-password $2