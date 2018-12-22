#!/bin/bash

kubectl create -f namespace.yml
kubectl create secret generic mysql-secrets --from-literal=rootpw=secret123 --namespace ns-test

# mysql
kubectl create -f mysql-vol.yml
nohup minikube mount $PWD/mysql-init:/mysql-init/ &
kubectl create -f mysql.yml

# php app
# https://kubernetes.io/docs/setup/minikube/#use-local-images-by-re-using-the-docker-daemon
eval $(minikube docker-env)
docker build -f php.Dockerfile -t php-test:1.0 .
kubectl create -f php.yml

# nginx
kubectl create -f nginx.yml


# expose it to http://localhost/code.php
sudo kubectl port-forward svc/nginx-service 80 --namespace=ns-test
