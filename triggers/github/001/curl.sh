#!/bin/bash

# Avvia il port-forward in background e registra il PID
kubectl port-forward service/el-github-listener 8080 >/dev/null 2>&1 &
KUBECTL_PID=$!

# Attendi che la porta 8080 sia disponibile (aggiungi un ritardo personalizzato se necessario)
echo "Attivazione port-forward..."
sleep 5  # Modifica questo valore se necessario

# Esegui la richiesta curl
curl -v \
-H 'X-GitHub-Event: pull_request' \
-H 'X-Hub-Signature: sha1=ba0cdc263b3492a74b601d240c27efe81c4720cb' \
-H 'Content-Type: application/json' \
-d '{"action": "opened", "pull_request":{"head":{"sha": "28911bbb5a3e2ea034daf1f6be0a822d50e31e73"}},"repository":{"clone_url": "https://github.com/tektoncd/triggers.git"}}' \
http://localhost:8080

# Termina il processo di port-forward
kill $KUBECTL_PID