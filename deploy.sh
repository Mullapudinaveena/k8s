docker build -t naveenauta/multi-client:latest -t naveenauta/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t naveenauta/multi-server:latest -t naveenauta/multi-server:$SHA -f ./server/Dockkerfile ./server
docker build -t naveenauta/multi-worker:latest -t naveenauta/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push naveenauta/multi-client:latest
docker push naveenauta/multi-server:latest
docker push naveenauta/multi-worker:latest

docker push naveenauta/multi-client:$SHA
docker push naveenauta/multi-server:$SHA
docker push naveenauta/multi-worker:$SHA


kubectl apply -f k8s 

kubectl set image deployements/server-deployment server=naveenauta/multi-server:$SHA
kubectl set image deployements/client-deployement client=naveenauta/multi-client:$SHA
kubectl set image deployements/worker-deployement worker=naveenauta/multi-worker:$SHA