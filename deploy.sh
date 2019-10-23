docker build -t amachi/multi-client:latest -t amachi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t amachi/multi-server:latest -t amachi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t amachi/multi-worker:latest -t amachi/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push amachi/multi-client:latest
docker push amachi/multi-server:latest
docker push amachi/multi-worker:latest

docker push amachi/multi-client:$SHA
docker push amachi/multi-server:$SHA
docker push amachi/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=amachi/multi-server:$SHA
kubectl set image deployments/client-deployment client=amachi/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=amachi/multi-worker:$SHA