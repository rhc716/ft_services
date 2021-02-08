# kind 설치 필요
# https://kind.sigs.k8s.io/docs/user/quick-start/#installation

# kind로 클러스터 삭제
kind delete cluster --name ftservice

# kind로 클러스터 생성
kind create cluster --name ftservice

# metallb 설치 및 적용
kubectl get configmap kube-proxy -n kube-system -o yaml | sed -e "s/strictARP: false/strictARP: true/" | kubectl diff -f - -n kube-system
kubectl get configmap kube-proxy -n kube-system -o yaml | sed -e "s/strictARP: false/strictARP: true/" | kubectl apply -f - -n kube-system
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f ./srcs/metallb.yaml

# 대쉬보드 설치
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
# Creating a Service Account
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
EOF
# Creating a ClusterRoleBinding
cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
EOF

######## 대쉬보드 사용법 #########
# 대쉬보드 토큰 생성
# kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"
# 프록시 실행
# kubectl proxy
# 대쉬보드 주소
# http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
#################################

#### NGINX ####
docker build ./srcs/nginx -t nginx
# kind load : cluster 에 빌드된 도커 이미지 load
kind load docker-image nginx --name ftservice
kubectl apply -f ./srcs/nginx/nginx.yaml

#### INFLUXDB ####
docker build ./srcs/influxdb -t influxdb
kind load docker-image influxdb --name ftservice
kubectl apply -f ./srcs/influxdb/influxdb.yaml

#### GRAFANA ####
docker build ./srcs/grafana -t grafana
kind load docker-image grafana --name ftservice
kubectl apply -f ./srcs/grafana/grafana.yaml

#### MYSQL ####
docker build ./srcs/mysql -t mysql
kind load docker-image mysql --name ftservice
kubectl apply -f ./srcs/mysql/mysql.yaml

#### PHPMYADMIN ####
docker build ./srcs/phpmyadmin -t phpmyadmin
kind load docker-image phpmyadmin --name ftservice
kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml

#### WORDPRESS ####
docker build ./srcs/wordpress -t wordpress
kind load docker-image wordpress --name ftservice
kubectl apply -f ./srcs/wordpress/wordpress.yaml

#### FTPS ####
docker build ./srcs/ftps -t ftps
kind load docker-image ftps --name ftservice
kubectl apply -f ./srcs/ftps/ftps.yaml
