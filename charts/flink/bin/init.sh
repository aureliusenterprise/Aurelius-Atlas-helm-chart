#!/bin/bash

# copy confgig files

cp /opt/flink/tasks-conf/config.py /opt/flink/py_libs/m4i-flink-tasks/scripts/config.py
cp /opt/flink/tasks-conf/credentials.py /opt/flink/py_libs/m4i-flink-tasks/scripts/credentials.py

# instakll m4i-flink-task library
cd /opt/flink/py_libs/m4i-flink-tasks
pip3 install -e .

# setup the atlas related default users
cd /opt/flink/py_libs/m4i-flink-tasks/scripts
python create_keycloak_users.py -u atlas -p KEYCLOAK_ATLAS_ADMIN_PASSWORD -r ["ROLE_ADMIN","DATA_STEWARD"]
python create_keycloak_users.py -u steward -p KEYCLOAK_ATLAS_STEWARD_PASSWORD -r ["DATA_STEWARD"]
python create_keycloak_users.py -u scientist -p KEYCLOAK_ATLAS_USER_PASSWORD -r ["DATA_SCIENTIST"]
