#!/bin/bash 

kubectl apply --filename \
https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml

kubectl apply --filename \
https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml
kubectl apply --filename \
https://storage.googleapis.com/tekton-releases/triggers/latest/interceptors.yaml

kubectl apply --filename \
https://storage.googleapis.com/tekton-releases/chains/latest/release.yaml