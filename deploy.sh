docker build -t hiranokuosaka/multi-client:latest -t hiranokuosaka/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hiranokuosaka/multi-server:latest -t hiranokuosaka/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hiranokuosaka/multi-worker:latest -t hiranokuosaka/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hiranokuosaka/multi-client:latest
docker push hiranokuosaka/multi-server:latest
docker push hiranokuosaka/multi-worker:latest

docker push hiranokuosaka/multi-client:$SHA
docker push hiranokuosaka/multi-server:$SHA
docker push hiranokuosaka/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hiranokuosaka/multi-server:$SHA
kubectl set image deployments/client-deployment client=hiranokuosaka/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hiranokuosaka/multi-worker:$SHA
