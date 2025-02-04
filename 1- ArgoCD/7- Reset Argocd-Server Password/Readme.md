# How to reset argocd-server password


###  Invalidating Admin Credentials
``` bash
# null password
kubectl patch secret argocd-secret -n argocd -p '{"data": {"admin.password": null, "admin.passwordMtime": null}}'

```

### Restarting ArgoCD Server Pods
``` bash
# delete pods
kubectl delete pods -n argocd -l app.kubernetes.io/name=argocd-server

```

### Decrypting the New Password
``` bash
# new password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

```