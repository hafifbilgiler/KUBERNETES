# hafifbilgiler
--------------------------Hafif Bilgiler------------------------------------------

Hi valuable user, you can initiate cluster with this yaml files , after create pod and other componnent you can use script to create redis cluster.

==============REDIS APPLICATION RUN ON KUBERNETES===========================================

1)Create Storage Class Resources Of Kubernetes

kubectl create -f redis-stclass.yaml

2)Create Persistent Volume  Resources Of Kubernetes 

kubectl create -f redis-pv.yaml

3)Create Redis Config Map Resources Of Kubernetes 

kubectl create -f redis-configmap.yaml

4)Create Redis Service Resources Of Kubernetes 

kubectl create -f redis-svc.yaml

5)Create Redis Statefulset Resources Of Kubernetes 

kubectl create -f redis.yaml

6)Use Initiate Script

