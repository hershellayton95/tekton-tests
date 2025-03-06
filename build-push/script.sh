#!/usr/bin/env sh

kubectl apply -f \
https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.6/git-clone.yaml

kubectl apply -f \
https://raw.githubusercontent.com/tektoncd/catalog/refs/heads/main/task/kaniko/0.6/kaniko.yaml