# PreRequisite:
- Install k8s
  - https://gitlab.com/sela-kubernetes-workshop/lab-01
## List of K8s server
https://docs.google.com/spreadsheets/d/1RYPJaOKE75J45QOCVvH3WolZlOSEcs8A8Ug0MgALWgs/edit?gid=0#gid=0
## List of Jenkins Server
https://docs.google.com/spreadsheets/d/1RYPJaOKE75J45QOCVvH3WolZlOSEcs8A8Ug0MgALWgs/edit?gid=0#gid=0

# Argo CD - GitOps

Argo CD is a Kubernetes-native continuous deployment (CD) tool. Unlike external CD tools that only enable push-based deployments, Argo CD can pull updated code from Git repositories and deploy it directly to Kubernetes resources

To trigger Argo CD automatically after your GitHub Actions CI pipeline, you need to ensure Argo CD pulls the latest changes from your Git repository — this is how GitOps works

**Note:** For More Explanation of ArgoCD manifest install.yaml file componentes go to end of page


## Remote Server and Local PC
### Remote Server
- PreRequisite:
  - Install k8s

```
kubectl create namespace argocd
kubectl get ns
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
  # Go to the buttom of page in order to see the info of Manifest install.yaml file 
kubectl get all -n argocd
kubectl get pod -n argocd
kubectl get svc -n argocd
  # Run the LoadBalancer
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
kubectl get svc -n argocd
kubectl get svc -n argocd -o wide --watch
```

- Go to the Browser and login to the ArgoCD login page with port 80
```
  http://<External-IP-Address-of-LB>:80
```
  - User: admin
  - Password: from command, kubectl -n argocd get secret command

```
  # Generate the password and type into login page of argocd
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d
```

![Alt text](pic-gh-argo-login-page.png)



## GitHub sync with App of ArgoCD
### GitHub New Public Repository
- Create New Public Repository ( fo r example: global-config-files )
- Create yaml file with latest of nginx webserver under new folder for example fp-argo-cd
- fp-argo-cd/nginx-pod.yaml
```
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: nginx
spec:
  containers:
    - name: nginx
      image: nginx:1.21
      ports:
        - containerPort: 80
```

### Sync App with ArgoCD

- Click on New App and type the nginx details

 ![Alt text](pic-gh-argocd.png) 

### Sync argocd with nginx webserver
- Click on Refresh and sync in order to sync argocd with nginx webserver

![Alt text](pic-gh-argo-app.png) 

### ArgoCD sync with app-node from GitHub Action lab

- Create yaml based on app-node image which including pod and svc ( As LoadBalancer )
- Copy the app-node.yaml file to the Github Repo of Argo sync
- Refresh and Sync from Argo dashboard  

```
apiVersion: v1
kind: Pod
metadata:
  name: app-node
  labels:
    app: app-node
spec:
  containers:
    - name: app-node
      image: dinghy123/app-node:latest
      ports:
        - containerPort: 3000
---
apiVersion: v1
kind: Service
metadata:
  name: app-node
spec:
  type: LoadBalancer
  selector:
    app: app-node
  ports:
    - name: http
      port: 80
      targetPort: 3000
```

- Run the commands below in order to check the new app-node application
```
kubectl get all -n default
kubectl exec -it pod/app-node -n default -- bash
  # Type the command, do not copy past its not work, just type the command in cli screen 
kubectl exec -it pod/app-node -n argocd -- bash

curl localhost:3000
kubectl get pod/app-node -n default -o yaml
kubectl get all -n default
```

- Go to the Browser with External-IP of LoadBalancer
```
http://<External-IP:80>
```
- app-node should up and running

![Alt text](pic-gh-node-app.png)

### Argo sync with new image version
- Go to devops-ci-cd-celebrating-small-victories -> lesson-cicd - > practice-01 - > Edit app.js
- Edit also the tag of workflow to latest-xyz
- Edit also the tag of global-config-files -> fp-argo-cd -> app-node.yaml
- Make Sure the GitHub Action is running and new Images with new tag is created
- ArgoCD sync the app-node
- **Refresh** the Browser - You should see the changed

#### Manifest **install.yaml** file Included:
  - This manifest includes all necessary Kubernetes objects to deploy a fully functional Argo CD instance

1. Namespaces
   Creates the argocd namespace
2. Services
   - argocd-server (UI & API)
   - argocd-repo-server (clones Git repos)
   - argocd-dex-server (OIDC authentication provider)
   - argocd-application-controller
   - argocd-redis (for caching)
3. Deployments
   - argocd-server
   - argocd-repo-server
   - argocd-application-controller
   - argocd-dex-server
   - argocd-redis
4. RBAC / Roles
   - Roles, RoleBindings, ServiceAccounts for internal communication and secure access
5. ConfigMaps and Secrets
   - Argo CD settings (argocd-cm)
   - RBAC (argocd-rbac-cm)
   - TLS and authentication secrets (argocd-secret)
6. Ingress/Service (optional external access)
   - Exposes the Argo CD UI and API (by default as a ClusterIP, but can be changed to LoadBalancer or Ingress manually).

