# hafifbilgiler
--------------------------General Codes------------------------------------------

Nginx Pod Create:
    
    kubectl create -f nginx-pod.yaml

Nginx ReplicaSet Create:
    
    kubectl create -f nginx-replicaset.yaml

Nginx Deployment Create:
    
    kubectl create -f nginx-deployment.yaml


Service Create For Nginx Deployment:

    kubectl create -f nginx-service.yaml

 
Job Create:

    kubectl create -f job.yaml   

Job Create For Backoff Limits:

    kubectl create -f job-backoff.yaml 

Job Create For Completions And Parallelism:

    kubectl create -f job-completions-parallelism.yaml

Job Create For TTL After Finished:

    kubectl create -f job-ttl.yaml
==============BOOKSTACK APPLICATION RUN ON KUBERNETES========================

Please follow the below queue

1) Create Bookstack Application PV Kubernetes Resources

    kubectl create -f bookstackpv.yaml

2) Create Bookstack Application PVC Kubernetes Resources

    kubectl create -f bookstackpvc.yaml

3) Create Bookstack Database Application PV Kubernetes Resources

    kubectl create -f bookstackdbpv.yaml

4) Create Bookstack Database Application PVC Kubernetes Resources

    kubectl create -f bookstackdbpvc.yaml

5) Create Bookstack Application PV Kubernetes Resources

    kubectl create -f bookstackpv.yaml

6) Create Bookstack Database Application Kubernetes Resources

    kubectl create -f bookstackdb.yaml

Below step will create, after take database pod ip and adding yaml file 

7) Create Bookstack Application Kubernetes Resources

    kubectl create -f bookstack.yaml

8) Create Bookstack Applicaiton Service Resources

    kubectl create -f bookstacksvc.yaml
