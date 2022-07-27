
kubectl port-forward service/flink-jobmanager 8081:8081 -n gaby

http://localhost:8081 


Flink resources
===============
- https://nightlies.apache.org/flink/flink-docs-master/docs/deployment/resource-providers/standalone/kubernetes/

- https://googlecloudplatform.github.io/flink-on-k8s-operator/
- https://github.com/nlecoy/flink-chart
- https://nightlies.apache.org/flink/flink-docs-master/docs/deployment/resource-providers/standalone/kubernetes/#common-cluster-resource-definitions
- https://artifacthub.io/packages/helm/riskfocus/flink
- https://github.com/ververica/ververica-platform-playground
- https://www.ververica.com/getting-started