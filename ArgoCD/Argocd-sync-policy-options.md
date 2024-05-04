ArgoCD Sync Policy Options Lists


``` bash
# Skip schema validation: 
When selected, bypasses validating the YAML schema.

# Auto-create namespace: 
When selected, automatically create the namespace if the specified namespace does not exist in the cluster.

# Prune last: 
When selected, removes those resources that do not exist in the currently deployed version during the final wave of the sync operation.

# Apply out of sync only: 
When selected, syncs only those resources in the application that have been changed and are OutOfSync, instead of syncing every resource regardless of their state. This option is useful to reduce load and save time when you have thousands of resources in an application.

# Selective sync: 
Currently when syncing using auto sync ArgoCD applies every object in the application. For applications containing thousands of objects this takes quite a long time and puts undue pressure on the api server. Turning on selective sync option which will sync only out-of-sync resources.
```

Prune Propagation Policy
``` bash
# Foreground: 
The default prune propagation policy used by Argo CD. With this policy, Kubernetes changes the state of the owner resource to `deletion in progress`, until the controller deletes the dependent resources and finally the owner resource itself.

#Background: 
When selected, Kubernetes deletes the owner resource immediately, and then deletes the dependent resources in the background.

#Orphan: 
When selected, Kubernetes deletes the dependent resources that remain orphaned after the owner resource is deleted.

# All Prune propagation policies can be used with:
# Replace: 
When selected, Argo CD executes kubectl replace or kubectl create, instead of the default kubectl apply to enforce the changes in Git. This action will potentially recreate resources and should be used with care. See Replace Resource Instead Of Applying Change.

# Retry: 
When selected, retries a failed sync operation, based on the retry settings configured:

    Maximum number of sync retries (Limit)
    Duration of each retry attempt in seconds, minutes, or hours (Duration)
    Maximum duration permitted for each retry (Max Duration)
    Factor by which to multiply the Duration in the event of a failed retry (Factor). A factor of 2 for example, attempts the second retry in 2 X 2 seconds, where 2 seconds is the Duration.

```