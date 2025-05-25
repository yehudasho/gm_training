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
```
