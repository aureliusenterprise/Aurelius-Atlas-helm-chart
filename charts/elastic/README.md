https://www.elastic.co/guide/en/cloud-on-k8s/master/k8s-deploy-elasticsearch.html
https://www.elastic.co/guide/en/cloud-on-k8s/master/k8s-deploy-kibana.html
https://www.elastic.co/guide/en/cloud-on-k8s/master/k8s-enterprise-search-quickstart.html


TO DEPLOY ECK on cluster
```
kubectl create -f https://download.elastic.co/downloads/eck/2.2.0/crds.yaml
kubectl apply -f https://download.elastic.co/downloads/eck/2.2.0/operator.yaml
```

kubectl port-forward service/kibana-kb-http 5601 -n gaby2
https://localhost:5601