#!/bin/bash

# Avvia il port-forward in background e registra il PID
kubectl port-forward service/el-github-owners-listener 8080 >/dev/null 2>&1 &
KUBECTL_PID=$!

# Attendi che la porta 8080 sia disponibile (aggiungi un ritardo personalizzato se necessario)
echo "Attivazione port-forward..."
sleep 5  # Modifica questo valore se necessario

# Esegui la richiesta curl
curl -v \
-H 'X-GitHub-Event: pull_request' \
-H 'X-Hub-Signature: sha1=70d0ebf86a7973374898b7711acc0897616e2c93' \
-H 'Content-Type: application/json' \
-d '{"action": "opened","number": 1503,"repository":{"full_name": "tektoncd/triggers", "clone_url": "https://github.com/tektoncd/triggers.git"}, "sender":{"login": "dibyom"}}' \
http://localhost:8080

# Termina il processo di port-forward
kill $KUBECTL_PID