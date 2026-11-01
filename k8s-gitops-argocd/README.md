# Kubernetes GitOps with ArgoCD

Git is the single source of truth: ArgoCD continuously syncs this repo to the cluster with self-heal and pruning. A reference implementation of the GitOps workflow I run across Dev/QA/UAT/Prod to reduce config drift and rollback time .

## Structure
```
apps/                 ArgoCD Applications (app-of-apps)
  root.yaml           bootstrap, applied once
  demo-app.yaml
manifests/demo-app/   namespace (Pod Security: restricted), deployment, service,
                      HPA, VPA (recommend mode), NetworkPolicies
```

## Bootstrap
```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -f apps/root.yaml
```

## What it demonstrates
- App-of-apps pattern with automated sync, `prune` and `selfHeal`
- Pod Security Standards (`restricted`) enforced at namespace level
- Default-deny ingress plus an explicit allow rule
- HPA for scaling, VPA in recommendation mode to right-size requests without conflicting with HPA
- Rollback = `git revert`

Before use, replace `menakamaheswari1234-cpu` in `apps/*.yaml`.
