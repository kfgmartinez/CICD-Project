#!/bin/sh
echo ---------- starting Script ----------
echo ---------- Applying Namespace ----------
kubectl apply -f namespace.yaml
echo ---------- Applying Secret ----------
kubectl apply -f secret.yaml
echo ---------- Applying Deployment ----------
kubectl apply -f deployment.yaml
echo ---------- Applying Service ----------
kubectl apply -f service.yaml
echo ---------- Summary -----------
kubectl get all -n kfgmartinez-namespace

