# Apache Atlas backup

## Acquire access token for Apache Atlas's admin user
You can use `oauth.sh` script from https://github.com/aureliusenterprise/Aurelius-Atlas-helm-chart. Example usage:
```
export ACCESS_TOKEN=$(./oauth.sh --endpoint https://aureliusdev.westeurope.cloudapp.azure.com/demo/auth/realms/m4i/protocol/openid-connect/token \
--client-id m4i_atlas \
--access atlas $ATLAS_USER_PASSWD)
```

## Export data from Apache Atlas
You can use `export-atlas.py` script, that wraps Apache Atlas's [Export API](https://atlas.apache.org/index.html#/ExportAPI) to export all data from Atlas. Example Usage:
```
pip install urlpath
python export-atlas.py --token $ACCESS_TOKEN \
--base-url https://aureliusdev.westeurope.cloudapp.azure.com/demo/atlas2/ \
--output out.zip
```

# Elasticsearch backup

For Elasticsearch backup you can use [Snapshot and restore API](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore.html).

## Create a snapshot repository

### Create a storage account and a container in Azure
1. Go to https://portal.azure.com/
2. Go to storage accounts service
   ![Zrzut ekranu 2024-03-13 143127.png](/.attachments/Zrzut%20ekranu%202024-03-13%20143127-09728c2f-d91b-4271-8329-7004a9235cb7.png)
3. Create a new storage account
   ![Zrzut ekranu 2024-03-13 143220.png](/.attachments/Zrzut%20ekranu%202024-03-13%20143220-dfb365e0-e6b2-4593-a132-d0628a986f31.png)
4. Set the account name. Optionally adjust the redundancy and access tier
   ![Zrzut ekranu 2024-03-13 144404.png](/.attachments/Zrzut%20ekranu%202024-03-13%20144404-c3dfdbe5-f1cb-4529-aca2-5f57d4abf1a7.png)
   ![Zrzut ekranu 2024-03-13 144711.png](/.attachments/Zrzut%20ekranu%202024-03-13%20144711-258aec7a-6c6c-4c22-9ff1-8b397d77ada8.png)
5. Review and create
6. Once the account is created, go to Containers tab
   ![Zrzut ekranu 2024-03-13 154545.png](/.attachments/Zrzut%20ekranu%202024-03-13%20154545-4fe60ad4-6594-43ba-be3d-c050a21e8cfe.png)
7. Create a new container
   ![image.png](/.attachments/image-54336a3d-aecc-492a-bc19-bb7d195bea70.png)
   ![image.png](/.attachments/image-c14bcccb-bd6e-4a54-b95b-4ff7ed55bc80.png)
8. Go to Access keys tab
   ![image.png](/.attachments/image-f48a39fa-1c94-44a0-8cae-b8ae85372c5f.png)

### Register a repository
1. Access Elastic's search pod/image, for example:
   ```
   kubectl -n demo exec -it pod/elastic-search-es-default-0 -- bash
   ```
2. Configure Elasticsearch's keystore with values from the Storage account's Access keys tab.
   ![Zrzut ekranu 2024-03-13 172223.png](/.attachments/Zrzut%20ekranu%202024-03-13%20172223-bee8a00e-797f-4554-a25e-3f277e60e74b.png)
   ```
   bin/elasticsearch-keystore add azure.client.default.account
   bin/elasticsearch-keystore add azure.client.default.key
   ```
3. Optionally set a password for the keystore
   ```
   bin/elasticsearch-keystore passwd
   ```
4. Reload secure settings
   ```
   curl -X POST -u "elastic:$ELASTIC_PASSWORD" "https://aureliusdev.westeurope.cloudapp.azure.com/demo/elastic/_nodes/reload_secure_settings?pretty" -H 'Content-Type: application/json' -d "
   {
       \"secure_settings_password\": \"$ELASTIC_KEYSTORE_PASSWORD\"
   }"
   ```
5. Create the repository
   ```
   curl -X PUT -u "elastic:$ELASTIC_PASSWORD" "https://aureliusdev.westeurope.cloudapp.azure.com/demo/elastic/_snapshot/demo_backup?pretty" -H 'Content-Type: application/json' -d "
   {
     \"type\": \"azure\",
     \"settings\": {
       \"container\": \"aurelius-atlas-elastic-backup\",
       \"base_path\": \"backups\",
       \"chunk_size\": \"32MB\",
       \"compress\": true
     }
   }"
   ```
### Create a snapshot
```
curl -X POST -u "elastic:$ELASTIC_PASSWORD" "https://aureliusdev.westeurope.cloudapp.azure.com/demo/elastic/_snapshot/demo_backup/snapshot_2" -H 'Content-Type: application/json' -d '
{
  "indices": ".ent-search-engine-documents-*"
}'
```

# Importing the data

## Importing to Apache Atlas
1. Make sure to turn off the Atlas-Elastic integration by cancelling the jobs in Flink (if you want to import Elasticsearch backup as well)
2. Import the data:
```
python export-atlas.py --token $ACCESS_TOKEN \
--base-url https://aureliusdev.westeurope.cloudapp.azure.com/<target-namespace>/atlas2/ \
--output out.zip \
--import-data
```
3. If you turned off Flink jobs, don't forget to turn them back on

## Importing to Elasticsearch
1. Make sure that the search engines are created in Enterprise Search
2. Go to Index Management page in Kibana
3. Close indices related to the search engines (.ent-search-engine-documents-*)
4. [Register the snapshot repository connection](https://dev.azure.com/AureliusEnterprise/Data%20Governance/_wiki/wikis/Data-Governance.wiki/141/Aurelius-Atlas-backup?_a=edit&anchor=register-a-repository)
5. Restore a snapshot
```
curl -X POST -u "elastic:$ELASTIC_PASSWORD" "https://aureliusdev.westeurope.cloudapp.azure.com/<target-namespace>/elastic/_snapshot/demo_backup/snapshot_2/_restore" -H 'Content-Type: application/json' -d '
{
  "indices": ".ent-search-engine-documents-*"
}'
```
