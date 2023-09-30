#!/bin/sh
echo ---------- starting Script ----------
echo ---------- Applying Namespace ----------
kubectl apply -f jenkins/workspace/_trend_multibranch_pipeline_main/Kubernetes/namespace.yaml
echo ---------- Applying Secret ----------
kubectl apply -f jenkins/workspace/_trend_multibranch_pipeline_main/Kubernetes/secret.yaml
echo ---------- Applying Deployment ----------
kubectl apply -f jenkins/workspace/_trend_multibranch_pipeline_main/Kubernetes/deployment.yaml
echo ---------- Applying Service ----------
kubectl apply -f jenkins/workspace/_trend_multibranch_pipeline_main/Kubernetes/service.yaml
echo ---------- Summary -----------
kubectl get all -n kfgmartinez-namespace

