docker build -t rajesh1982002/multi-client:latest -t rajesh1982002/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rajesh1982002/multi-server:latest -t rajesh1982002/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rajesh1982002/multi-worker:latest -t rajesh1982002/multi-worker:$SHA -f ./worker/Dockerfile ./worker


docker push rajesh1982002/multi-client:latest
docker push rajesh1982002/multi-server:latest
docker push rajesh1982002/multi-worker:latest


docker push rajesh1982002/multi-client:$SHA
docker push rajesh1982002/multi-server:$SHA
docker push rajesh1982002/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rajesh1982002/multi-server:$SHA
kubectl set image deployments/client-deployment client=rajesh1982002/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rajesh1982002/multi-worker:$SHA
