#!/bin/bash
cd 1.1-argocd-installation-manual-steps

oc apply -f 1-argo-ns.yaml
# oc apply -f 2-argo-og.yaml
# oc apply -f 3-argo-sub.yaml

echo Waiting 30 seconds for ArgoCD Operator to come up, if the following step fails with the
echo error of \"no matches for kind ArgoCD\" then reload the \"5-argo-cluster.yaml\" file manually
echo using \"oc apply -f 5-argo-cluster.yaml\".

sleep 30

oc apply -f 5-argo-cluster.yaml
oc apply -f 6-argocd-cluster-admin.yaml
oc apply -f 7-security-contraint.yaml

echo Waiting 60 seconds for ArgoCD to come up
sleep 60

cd ..
oc apply -f 1.2-argocd-self-gitops/

sleep 1

### for the initial concurrency issue
oc apply -f 2-namespaces/
sleep 1
oc apply -f 3-permissions/
sleep 1


