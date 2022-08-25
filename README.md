Getting started
===============
Welcome to the Aurelius Atlas solution powered by Apache Atlas! Aurelius Atlas is an open-source Data Governance solution, based on a selection of open-source tools to facilitate business users to access governance information in an easy consumable way and meet the data governance demands of the distributed data world.



Installation Instructions
=========================

This installation assumes that you have a kubernetes cluster running.

1. Install Certificate manager:
```commandline
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install  --name cert-manager   --namespace cert-manager   --version v1.1.0   jetstack/cert-manager
```
2. Install Ingress Nginx Controller
```commandline
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install nginx-ingress ingress-nginx/ingress-nginx --set controller.publishService.enabled=true
```
3. Install Elastic
```commandline
kubectl create -f https://download.elastic.co/downloads/eck/2.3.0/crds.yaml
kubectl apply -f https://download.elastic.co/downloads/eck/2.3.0/operator.yaml
```
4. Deploying frist time on cluster
```commandline

```

Installation
============

configure public hostname

```bash
kubectl create namespace anwo
cd helm-governance
helm dependency update
helm install --generate-name -n <namespace>  -f values.yaml .
./get_passwords.sh <namespace>
kubectl -n <namespace> get all # check that alll pods are running
kubectl -n <namespace> exec -it <pod/flink-jobmanager-f795bd969-f4lpk> -- bash
cd init
./init_jobs.sh
./load_sample_data.sh
```



Elastic:
===================
- In order to deploy elastic, ``Elastic Cluster on Kubernetes (ECK)`` must be installed on the cluster. To install ECK on the cluster, please follow the instructions provided on https://www.elastic.co/guide/en/cloud-on-k8s/master/k8s-deploy-eck.html
- For more details about this elastic helm chart look at [elastic readme](./charts/elastic/README.md)

Flink:
===================
- For more details about this flink helm chart look at [flink readme](./charts/flink/README.md)


Atlas is now accessible via reverse proxy at
https://aureliusdev.westeurope.cloudapp.azure.com/anwo/atlas2/login.jsp


