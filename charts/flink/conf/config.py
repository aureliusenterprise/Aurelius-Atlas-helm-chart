config = {
    "atlas.server.url": "atlas.{{ .Release.Namespace }}.svc.cluster.local:21000/api/atlas",
    "kafka.bootstrap.server.hostname": "kafka.{{ .Release.Namespace }}.svc.cluster.local",
    "kafka.bootstrap.server.port": "9092",
    "kafka.consumer.group.id": "{{ .Release.Namespace }}",
    "atlas.audit.events.topic.name": "ATLAS_ENTITIES",
    "enriched.events.topic.name": "ENRICHED_ENTITIES",
    "determined.events.topic.name": "DETERMINED_CHANGE",
    "exception.events.topic.name": "DEAD_LETTER_BOX",

    "elastic.search.index" : "atlas-dev-test",
    "elastic.app.search.engine.name" : "atlas-dev-test",

    "elastic.cloud.username" : "elastic",
    "elastic.cloud.id" : None,
    "elastic.base.endpoint" : "elastic.{{ .Release.Namespace }}.svc.cluster.local/api/as/v1",
    "elastic.search.endpoint" : "https://elastic-search.{{ .Release.Namespace }}.svc.cluster.local:443",
    "elastic.enterprise.search.endpoint" : "https://enterprise-search.{{ .Release.Namespace }}.svc.cluster.local:443",

    "keycloak.server.url" : "https://{{ .Values.external_hostname }}/{{ .Release.Namespace }}/auth/",
    "keycloak.client.id" : "m4i_public",
    "keycloak.realm.name": "m4i",    
}