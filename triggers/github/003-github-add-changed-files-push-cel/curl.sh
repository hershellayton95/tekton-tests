#!/bin/bash

# Avvia il port-forward in background e registra il PID
kubectl port-forward service/el-github-add-changed-files-push-cel-listener 8080 >/dev/null 2>&1 &
KUBECTL_PID=$!

# Attendi che la porta 8080 sia disponibile (aggiungi un ritardo personalizzato se necessario)
echo "Attivazione port-forward..."
sleep 5  # Modifica questo valore se necessario

# Esegui la richiesta curl
 curl -v \
 -H 'X-GitHub-Event: push' \
 -H 'Content-Type: application/json' \
 -d '{"repository":{"full_name":"testowner/testrepo","clone_url":"https://github.com/testowner/testrepo.git"},"commits":[{"added":["api/v1beta1/tektonhelperconfig_types.go","config/crd/bases/tekton-helper..com_tektonhelperconfigs.yaml"],"removed":["config/samples/tektonhelperconfig-oomkillpipeline.yaml","config/samples/tektonhelperconfig-timeout.yaml"],"modified":["controllers/tektonhelperconfig_controller.go"]}]}' \
 http://localhost:8080

# Termina il processo di port-forward
kill $KUBECTL_PID