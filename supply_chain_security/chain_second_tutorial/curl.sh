#!/bin/bash

# cosign generate-key-pair k8s://tekton-chains/signing-secrets

kubectl patch configmap chains-config -n tekton-chains -p='{"data":{"artifacts.oci.storage": "", "artifacts.taskrun.format":"in-toto", "artifacts.taskrun.storage": "tekton"}}'

kubectl delete po -n tekton-chains -l app=tekton-chains-controller

cat <<EOF | kubectl apply -f -
apiVersion: tekton.dev/v1
kind: TaskRun
metadata:
  name: build-push-run-output-image-test
spec:
  serviceAccountName: ""
  taskSpec:
    results:
    - name: IMAGE_URL
      type: string
    - name: IMAGE_DIGEST
      type: string
    steps:
    - name: create-image
      image: busybox
      script: |-
        #!/usr/bin/env sh
        echo 'gcr.io/foo/bar' | tee \$(results.IMAGE_URL.path)
        echo 'sha256:05f95b26ed10668b7183c1e2da98610e91372fa9f510046d4ce5812addad86b5' | tee \$(results.IMAGE_DIGEST.path)
EOF