

https://nightlies.apache.org/flink/flink-docs-master/docs/deployment/resource-providers/standalone/docker/#:~:text=The%20Flink%20Docker%20repository%20is,aliases%20are%20provided%20for%20convenience.


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



Keycloak client id mappings:
Realm: m4i
- Apache Atlas Frontend: m4i_thijs - m4i_atlas_frontend
- Apache Atlas standard: m4i_atlas


Configure keycloak to use gmail as a Idendity provider
https://keycloakthemes.com/blog/how-to-setup-sign-in-with-google-using-keycloak

redirect URL https://aureliusdev.westeurope.cloudapp.azure.com/anwo/auth/realms/m4i/broker/google/endpoint

#### to get the password to keycloak admin user:
```commandline
kubectl get secret keycloak-secret -o=jsonpath='{.data.password}' -n anwo | base64 --decode; echo
```
#### to get the password to elastic user:
```commandline
kubectl get secret elastic-search-es-elastic-user -o=jsonpath='{.data.elastic}' -n namespace | base64 --decode; echo
```

# Debugging rewrite rules
enable logging in httpd.conf

```
ErrorLog logs/error_log
#
# LogLevel: Control the number of messages logged to the error_log.
# Possible values include: debug, info, notice, warn, error, crit,
# alert, emerg.
#
LogLevel debug rewrite:trace6

<IfModule log_config_module>
    #
    # The following directives define some format nicknames for use with
    # a CustomLog directive (see below).
    #
    LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
    LogFormat "%h %l %u %t \"%r\" %>s %b" common

    <IfModule logio_module>
      # You need to enable mod_logio.c to use %I and %O
      LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %I %O" combinedio
    </IfModule>

    #
    # The location and format of the access logfile (Common Logfile Format).
    # If you do not define any access logfiles within a <VirtualHost>
    # container, they will be logged here.  Contrariwise, if you *do*
    # define per-<VirtualHost> access logfiles, transactions will be
    # logged therein and *not* in this file.
    #
    #CustomLog /var/log/httpd/access common

    #
    # If you prefer a logfile with access, agent, and referer information
    # (Combined Logfile Format) you can use the following directive.
    #
    CustomLog "logs/access_log" combined
</IfModule>
```