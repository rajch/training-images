#!/bin/bash
set -e

echo "Fetching and installing Helm 2..."
curl -L https://raw.githubusercontent.com/helm/helm/master/scripts/get | /bin/bash

echo "Creating RBAC permissions for tiller..."
kubectl create serviceaccount --namespace kube-system tiller 2>/dev/null
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller 2>/dev/null

echo "Initializing Helm 2..."
helm init --service-account tiller --upgrade
helm update repo

echo "Done."