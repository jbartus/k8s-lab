```
EFS_ID="$(terraform output -raw efs_id)" envsubst < my-app/efs-pv.yaml.template > my-app/efs-pv.yaml
```
```
export ECR_REPO_URL="$(terraform output -raw repository_url)"
envsubst < my-app/deployment.yaml.template > my-app/deployment.yaml
export AWS_ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com
docker build -t php-apache-mysql ./my-app
docker tag php-apache-mysql:latest ${ECR_REPO_URL}:latest
docker push ${ECR_REPO_URL}:latest
```
```
kubectl apply -f my-app/
```
```
kubectl port-forward svc/mysql 3306:3306
mysql -h 127.0.0.1 -P 3306 -u root -pyour_root_password < my-app/schema.sql
mysql -h 127.0.0.1 -P 3306 -u root -pyour_root_password < my-app/data.sql
```
```
kubectl cp my-app/index.php "$(kubectl get pods -l app=my-app --output=jsonpath='{.items[0].metadata.name}'):/var/www/html"
```
```
kubectl delete service my-app-service
```