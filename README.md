
Installation
============

```bash
kubectl create namespace anwo
helm install --generate-name -n anwo  -f helm-governance/values.yaml helm-governance
```

Additions May 10th:
===================
- moved reverse-proxy and keycloak as sub charts
- configured the reverse-proxy with a connection to keycloak
- testing is possible with port_forawing to reverse-proxy
kubectl port-forward -n anwo service/reverse-proxy 8080:8080
  
keycloak Realm:
- add realm files to ``charts/keycloak/realms``  
- update the value ``realm_file_name`` to the desired realm
kubectl port-forward -n gaby service/keycloak 8080:8080
  
Persistent Volume:
- update the value ``persistence`` to the desired properties wanted for the persistent volume.
- deleting the PVC removes the PV deleting the data
- When pod is deleted the data persists.

atlas Configuration:
- update ``charts/atlas/templates/configmap.yaml`` to change the configurations
- single pv for data folder including h2-base, solr, and zookeeper
kubectl port-forward -n gaby service/atlas 8080:21000


Elastic:
===================
- In order to deploy elastic, ``Elastic Cluster on Kubernetes (ECK)`` must be installed on the cluster. To install ECK on the cluster, please follow the instructions provided on https://www.elastic.co/guide/en/cloud-on-k8s/master/k8s-deploy-eck.html
- For more details about this elastic helm chart look at [elastic readme](./charts/elastic/README.md)

Flink:
===================
- For more details about this flink helm chart look at [flink readme](./charts/flink/README.md)





Create subcharts
 cd mychart/charts
 helm create mysubchart


some pointers for installing ingress
=====================================
- https://www.patrickriedl.at/secure-azure-kubernetes-with-lets-encrypt-certificates/
- https://github.com/fbeltrao/aks-letsencrypt/blob/master/install-nginx-ingress.md
- https://medium.com/@GeoffreyDV/how-to-set-up-ssl-certificates-for-free-on-azure-kubernetes-service-with-lets-encrypt-c7daca4e9385
- https://stacksimplify.com/azure-aks/ingress-ssl-with-lets-encrypt/
- https://stacksimplify.com/azure-aks/ingress-ssl-with-lets-encrypt/
- https://docs.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli
- https://docs.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli
- https://github.com/kubernetes/ingress-nginx
- https://kubernetes.github.io/ingress-nginx/deploy/#quick-start
- https://nws.netways.de/tutorials/kubernetes-nginx-ingress-controller-this-is-how-you-make-a-simple-start/

post precessing after pod is running
====================================
- https://stackoverflow.com/questions/44140593/how-to-run-command-after-initialization


Atlas is now accessible via reverse proxy at
https://aureliusdev.westeurope.cloudapp.azure.com/anwo/atlas2/login.jsp


Keycloak client id mappings:
Realm: m4i
- Apache Atlas Frontend: m4i_thijs - m4i_atlas_frontend
- Apache Atlas standard: m4i_atlas

Default users: 
There are no default users. 
There is a possibility to import default users using an import script https://github.com/UKHomeOffice/keycloak-utils
which I did not check out yet.

Configure keycloak to use gmail as a Idendity provider
https://keycloakthemes.com/blog/how-to-setup-sign-in-with-google-using-keycloak

redirect URL https://aureliusdev.westeurope.cloudapp.azure.com/anwo/auth/realms/m4i/broker/google/endpoint
