# sample deployments

```
kubectl create -f nginx-deployment
```

Expose it to internet:

```
kubectl expose deployment nginx-deployment --port=80 --type=LoadBalancer
```

Cleanup:

```
kubectl delete deployment nginx-deployment

```