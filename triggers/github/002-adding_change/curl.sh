#!/bin/bash

# Avvia il port-forward in background e registra il PID
kubectl port-forward service/el-github-add-changed-files-pr-listener  8080 >/dev/null 2>&1 &
KUBECTL_PID=$!

# Attendi che la porta 8080 sia disponibile (aggiungi un ritardo personalizzato se necessario)
echo "Attivazione port-forward..."
sleep 5  # Modifica questo valore se necessario

# Esegui la richiesta curl
curl -v \
-H 'X-GitHub-Event: pull_request' \
-H 'Content-Type: application/json' \
-d '{"action": "opened","number": 1503,"pull_request": {"head": {"sha": "16dd484bb4888dd30154f5ccb765beae1aaf72de"}},"repository": {"full_name": "tektoncd/triggers","clone_url": "https://github.com/tektoncd/triggers.git"}}' \
http://localhost:8080

# Termina il processo di port-forward
kill $KUBECTL_PID