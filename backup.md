# Aurelius Atlas Backup

Here you will find how to back up Aurelius Atlas for moving instances.

This process will result in zip files of the Aurelius Atlas instance that can be used for backup and in the case of disaster recover process. 


### Apache Atlas Backup Process Overview
![img_2.png](backup-overview.png)

The Import-Export APIs for Atlas facilitate transfer of data to and from an instance of Apache Atlas.
These APIs are available only to **admin user**.
To connect to the atlas backend a bearer token of an admin user is needed.

Get Bearer Token for admin user:
```bash
curl -d 'client_id=m4i_public' -d "username=$KEYCLOAK_ATLAS_USER_USERNAME" -d "password=$KEYCLOAK_ATLAS_ADMIN_PASSWORD" -d 'grant_type=password' \
                "${KEYCLOAK_SERVER_URL}realms/m4i/protocol/openid-connect/token"
```

## Export Backup of Atlas Instance
Apache Atlas exposes an Export API from where data is exported via a zip file.
Admin user need to specify the scope of the data to be exported, through the key "itemsToExport" in the request json.
This command will download a file response.zip to the current directory. This zip file can be saved and kept as a backup.

```bash
curl -o response.zip --location --request POST '<apache-atlas-url>/api/atlas/admin/export' \
--header 'Authorization: Bearer <Bearer-Token>' \
--header 'Content-Type: application/json' \
--data-raw '{
    "itemsToExport": [
        {
            "typeName": "m4i_data_domain",
            "uniqueAttributes": {
                "qualifiedName": "e"
            }
        }
    ],
    "options": {
        "fetchType": "full",
        "matchType": "contains"
    }
}'
```

#### How to get all entities to add to "itemsToExport": 
To get all the "itemsToExport" in to export request the results of request can be used:

```bash
curl -X GET -H 'Authorization: Bearer <Bearer-Token>'   <apache-atlas-url>/api/atlas/v2/search/basic/?typeName=_ALL_ENTITY_TYPES&limit=1000

```
Copy all under the "entities" key and place in "itemsToExport" in the export request.
If there are more than 1000 items in the atlas instance, send the request again and add an offset to the query (&offset=1000, &offset=2000) until you have all entities.


## Import Backup to Atlas Instance
Apache Atlas exposes an Import API from where data is imported from a zip file.
Admin user need rights are needed to use this api.
This command will import a file response.zip in the current directory to a specified atlas instance.

```bash
curl -g -X POST -H 'Authorization: Bearer <Bearer-Token>' -H "Content-Type: multipart/form-data" -H "Cache-Control: no-cache" -F data=@response.zip <apache-atlas-url>/api/atlas/admin/import

```
