## clone the repo
```
git clone https://github.com/jbartus/k8s-lab.git
cd k8s-lab
```

## run terraform
terraform init
terraform apply -auto-approve
```
## configure kubectl credentials
```
aws eks update-kubeconfig --name $(terraform output -raw cluster_name)
```

## set gp2 as default storage class
```
kubectl annotate storageclass gp2 storageclass.kubernetes.io/is-default-class=true
```

## run an nginx pod
```
kubectl run nginx --image=nginx
```

## expose it to the internet
```
kubectl expose deployment nginx --port=80 --type=LoadBalancer
```

## get the public ip of the nginx service
```
kubectl get svc nginx
```