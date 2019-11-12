docker build -t johnjude/multi-client:latest -t johnjude/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t johnjude/multi-server:latest -t johnjude/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t johnjude/multi-worker:latest -t johnjude/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push johnjude/multi-client:latest
docker push johnjude/multi-server:latest
docker push johnjude/multi-worker:latest

docker push johnjude/multi-client:$SHA
docker push johnjude/multi-server:$SHA
docker push johnjude/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=johnjude/multi-server:$SHA
kubectl set image deployments/client-deployment client=johnjude/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=johnjude/multi-worker:$SHA