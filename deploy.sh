docker build -t prasad890/multi_client:latest -t prasad890/multi_client:$SHA -f ./client/Dockerfile ./client
docker build -t prasad890/multi_server:latest -t prasad890/multi_server:$SHA -f ./server/Dockerfile ./server
docker build -t prasad890/multi_worker:latest -t prasad890/multi_worker:$SHA -f ./worker/Dockerfile ./worker

docker push prasad890/multi_client:latest
docker push prasad890/multi_server:latest
docker push prasad890/multi_worker:latest

docker push prasad890/multi_client:$SHA
docker push prasad890/multi_server:$SHA
docker push prasad890/multi_worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=prasad890/multi_server:$SHA
kubectl set image deployments/client-deployment client=prasad890/multi_client:$SHA
kubectl set image deployments/worker-deployment worker=prasad890/multi_worker:$SHA