# My Notes and Questions


Notes
``` bash
1- How to feature branch deployment with argocd? 

2- Should you use image uptader? What is do advantage and disadvantage

3- Read autopilot documets

4- Webhook integration

```

apiVersion: v1
 kind: ConfigMap
 metadata:
 labels:
 app.kubernetes.io/name: argocd-image-updater-config
 app.kubernetes.io/part-of: argocd-image-updater
 name: argocd-image-updater-config
 data:
 registries.conf: |
 registries:
 - name: Google Container Registry
 prefix: eu.gcr.io
 api_url: https://eu.gcr.io
 ping: no
 credentials: secret:<secret-namespace>/<secret-name>#<you-key>
