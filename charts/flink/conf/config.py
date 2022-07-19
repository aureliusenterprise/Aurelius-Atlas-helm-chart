config = {
    "atlas.server.url": "http://atlas.anwo.svc.cluster.local:21000/api/atlas",
   "kafka.bootstrap.server.hostname": "atlas.anwo.svc.cluster.local",
    "kafka.bootstrap.server.port": "9027",
    "kafka.consumer.group.id": None,
    "atlas.audit.events.topic.name": "ATLAS_ENTITIES",
    "enriched.events.topic.name": "ENRICHED_ENTITIES",
    "determined.events.topic.name": "DETERMINED_CHANGE",
    "exception.events.topic.name": "DEAD_LETTER_BOX",

    "elastic_search_index" : "atlas-dev-test",

    "elastic_cloud_username" : "YOUR_ELASTIC_USER_NAME",
    "elastic_cloud_id" : "YOUR_ELASTIC_CLOUD_ID",
    "elastic_base_endpoint" : "APP-SEACRH-HOSTNAME/api/as/v1",

    "keycloak.server.url" : "reliusdev.westeurope.cloudapp.azure.com/anwo/auth/",
    "keycloak.client.id" : "m4i_public",
    "keycloak.realm.name": "m4i",    
}