# K8s Lab 01
https://gitlab.com/sela-kubernetes-workshop/lab-01

## Extra lab - pod + rs + svc

- Run on one shot the my-pod-rs-svc.yaml file
```
kubectl apply -f my-pod-rs-svc.yaml
kubectl port-forward svc/example-service 8080:80
```
## K8s Common commands

```
kubectl cluster-info
kubectl version​
kubectl get nodes​
kubectl get namespaces
kubectl get pods --all-namespaces​
kubectl describe node minikube​
kubectl get pod​
kubectl get svc​
docker ps​
docker images
kubectl describe pod example-pod​
kubectl logs example-pod​
kubectl logs example-pod -c my-container​
kubectl exec -it example-pod bash​                          # kubectl exec -it example-pod -- /bin/bash​
exit​
kubectl get svc​
kubectl describe svc nginx​
kubectl get namespaces​
kubectl config set-context --current --namespace=<>
kubectl cluster-info
kubectl config get-contexts
kubectl config get-contexts | awk '{print $1,$5}'
```

- Cleanup
```
kubectl delete all --all     
kubectl delete svc --all
kubectl delete configmap --all
kubectl delete secret --all
kubectl delete pvc --all
kubectl delete ingress --all
```


### Lab-02 Deployment

# Kubernetes Deployment
A Kubernetes Deployment is used to manage the deployment, scaling, and rolling updates of a group of Pods
It ensures that the desired number of pod replicas are running and automatically replaces failed pods

Deployment Strategy in Kubernetes
Kubernetes Deployments support strategies for updating Pods when you make changes (like changing the image version)
The most common strategy is rolling update, but there's also recreate.

## Two Main Strategies
- **RollingUpdate (default)**
Updates Pods gradually to ensure zero downtime.
Creates new Pods and deletes old ones incrementally.
You can control the speed with:
  - maxUnavailable — how many old pods can be unavailable during the update.
  - maxSurge — how many extra new pods can be created beyond desired replicas

- **Recreate**
Deletes all old Pods first, then creates new ones.
Simpler, but may cause downtime.
Useful when old and new versions cannot run together (e.g., conflicting DB schema versions).

## Hands-On - Exercise 03 - my first Deployment

  - Create yaml file of my-first-deployment.yaml based on 1.21 image of nginx
  - Apply the Deployment​ 
  - Get the List and Describe of Deployments
  - Change the scale of rs from 3 to 5

  - Change the version of nginx to latest image
  - Apply the new version of deployment
  - Check the status of the deployment rollout
  - Rollback a Deployment
  - Delete a Deployment

- Cleanup Environment

```
kubectl delete all --all
kubectl get pods
kubectl get svc
kubectl get replicaset
kubectl delete deployment
```

- Get information of cluster

```
kubectl get ns
kind get clusters
kubectl config get-contexts
```

## Solution

-  Apply Deployment

```
kubectl apply -f first-deployment.yaml
kubectl get pods
kubectl get svc
kubectl get rs
kubectl port-forward example-deployment-6fbb7d8d8f-7gfdb 8080:80
```
- Go to the browser http://localhost:8080/

- Get, Describe and Scale deployment
```
kubectl get deployments
kubectl describe deployment example-deployment
kubectl scale deployment example-deployment --replicas=2
kubectl get deployments
```

- Apply the new version of Deployment

```
kubectl apply -f first-deployment-latest-nginx.yaml
kubectl rollout status deployment example-deployment
```

- Rollback a Deployment:

```
kubectl rollout undo deployment example-deployment
kubectl describe deployment example-deployment
kubectl describe pods
kubectl get deployments
kubectl delete deployment example-deployment
```

