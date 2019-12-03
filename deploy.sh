docker build -t batnasan/multi-client:latest -t batnasan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t batnasan/multi-server:latest -t batnasan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t batnasan/multi-worker:latest -t batnasan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push batnasan/multi-client:latest
docker push batnasan/multi-server:latest
docker push batnasan/multi-worker:latest

docker push batnasan/multi-client:$SHA
docker push batnasan/multi-server:$SHA
docker push batnasan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=batnasan/multi-server:$SHA
kubectl set image deployments/client-deployment server=batnasan/multi-client:$SHA
kubectl set image deployments/worker-deployment server=batnasan/multi-worker:$SHA