# Elastic

In order to deploy elastic the ``Elastic Cluster on Kubernetes (ECK)`` must be installed on the cluster. To install ECK on the cluster, please follow the instructions provided on https://www.elastic.co/guide/en/cloud-on-k8s/master/k8s-deploy-eck.html

Once ECK is installed on the cluster, the elastic helm charts can be deployed. 
#### This helm chart includes:
- elastic search with persistent volume
- kibana
- enterprise search

#### What can be changed in the values:
- persistent volume (size, enabled)
- version
- replicaCount


###To access service use the following command:
```commandline
kubectl port-forward service/kibana-kb-http 5601 -n namespace
```
Open the browser to https://localhost:5601

What still needs to be done:
===========================
- creation of additional users
- relating the login to the keycloak instance with SSO
- setting up the app search engine with the related settings and credentials

Some of these items will be handeled by infastructure as code.




Resources found for elastic
===========================
- https://www.elastic.co/guide/en/cloud-on-k8s/master/k8s-deploy-elasticsearch.html
- https://www.elastic.co/guide/en/cloud-on-k8s/master/k8s-deploy-kibana.html
- https://www.elastic.co/guide/en/cloud-on-k8s/master/k8s-enterprise-search-quickstart.html




- https://www.elastic.co/guide/en/app-search/current/installation.html#installation-docker
- https://www.docker.elastic.co/r/enterprise-search
- https://www.elastic.co/guide/en/enterprise-search/8.2/docker.html

- https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-deploy-elasticsearch.html
kubectl -n anwo port-forward service/elasticsearch-master 9200
http://127.0.0.1:9200/