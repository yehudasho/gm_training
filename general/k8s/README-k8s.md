# K8s Lab 01
list of servers
https://docs.google.com/spreadsheets/d/1RYPJaOKE75J45QOCVvH3WolZlOSEcs8A8Ug0MgALWgs/edit?gid=0#gid=0

https://gitlab.com/sela-kubernetes-workshop/lab-01
user: sela
password: S1234!

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

## K8s ConfigMap

# K8s ConfigMap
Configmap It’s just a way to manage configuration independent of the container image
using a ConfigMap any cluster environment (dev, staging, prod)
- ConfigMaps are environment-agnostic.
- You can create different ConfigMaps for different environments:
  - app-config-dev
  - app-config-prod
- Then use the appropriate one in each Pod depending on the environment

- You can inject different versions of a file (like index.html) using a single ConfigMap
  but not dynamically at runtime per environment
  Instead, you update the existing ConfigMap with the new content and re-apply the Pod or Deployment
- **The kube-root-ca.crt in ConfigMap** is Allow Pods to securely communicate with the Kubernetes API server using TLS
  its automatically created in each namespace by the Kubernetes control plane
  It contains the cluster's root Certificate Authority (CA) certificate
  and it's used by workloads (Pods) inside the cluster to securely communicate with the Kubernetes API server over HTTPS
    - the Purpose is TLS validation: Applications inside Pods can verify the identity of the API server.
      Secure service account token usage: Used in conjunction with the
    - Mount the CA cert at /var/run/secrets/kubernetes.io/serviceaccount/ca.crt inside Pods.

  ## Configmap Lab-01 - step by step index.html
- Inject different versions of a **index.html file**  using a single ConfigMap
  but not dynamically at runtime per environment
- Instead, you update the existing ConfigMap with the new content and re-apply the Pod

- Create index.html file
```
<!DOCTYPE html>
<html>
<head><title>Env</title></head>
<body><h1>Hello from ConfigMap Dev!</h1></body>
</html>
```

- Create the ConfigMap
  
```
kubectl create configmap html-config --from-file=index.html
kubectl get configmap
kubectl get configmap -o yaml
```

- Mount the ConfigMap in a Pod, see the example pod-with-configmap.yaml

```
apiVersion: v1
kind: Pod
metadata:
  name: html-pod
spec:
  containers:
  - name: nginx
    image: nginx
    volumeMounts:
    - name: html-volume
      mountPath: /usr/share/nginx/html/index.html
      subPath: index.html
  volumes:
  - name: html-volume
    configMap:
      name: html-config
```

- Aplly the pod
  
```
kubectl apply -f pod-with-configmap.yaml
```

- Port forward to the Browser

```
kubectl port-forward pod/html-pod 8080:80
```

- Go to the Browser
  - http://localhost:8080/
    
- Update the ConfigMap with a new version (Prod)

```
<!DOCTYPE html>
<html>
<head><title>Env</title></head>
<body><h1>Hello from ConfigMap Prod!</h1></body>
</html>
```

- Update the ConfigMap

```
kubectl create configmap html-config --from-file=index.html --dry-run=client -o yaml | kubectl apply -f -
```

- Delete and recreate the Pod

```
kubectl delete pod html-pod
kubectl apply -f pod-with-configmap.yaml
```

- Port forward to the Browser

```
kubectl port-forward pod/html-pod 8080:80
```

- Go to the Browser
  - http://localhost:8080/

 ## ConfigMap Lab-02 with app.properties

- Create the /config/app.properties file ( see the file in config folder )
```
# app.properties
app.name=MyKubeApp
app.environment=development
```
- Create a ConfigMap from the file
```
kubectl create configmap app-config --from-file=app.properties
kubectl describe configmap app-config
```

- Use the ConfigMap in a config-pod-properties.yaml (mount as file)
```
apiVersion: v1
kind: Pod
metadata:
  name: app-with-config
spec:
  containers:
  - name: myapp
    image: busybox
    command: [ "sh", "-c", "cat /config/app.properties && sleep 3600" ]
    volumeMounts:
    - name: config-volume
      mountPath: /config
  volumes:
  - name: config-volume
    configMap:
      name: app-config
```

- Deploy the Pod

```
kubectl apply -f pod.yaml
```

- Check if the file is mounted

```
kubectl exec app-with-config -- cat config/app.properties
```

  - Usage commands
```
kubectl get configmap
kubectl create configmap app-config --from-file=app.properties
kubectl describe configmap app-config
kubectl apply -f configmap-pod-properties.yaml
kubectl exec app-with-config -- cat config/app.properties
kubectl delete configmap --all
```

