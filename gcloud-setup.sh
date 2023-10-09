#!/usr/bin/env bash
# Interact with GCP via gcloud
gcloud auth login

# Interact with GCP via SDK (example Terraform)
gcloud auth application-default login

# gke-gcloud-auth-plugin needed as the open source community is requiring that all provider-specific code that currently exists in the OSS code base be removed starting with v1.26:
# https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
gcloud components install gke-gcloud-auth-plugin

# The command line with parameters can be accessed from the cluster list page:
# https://console.cloud.google.com/kubernetes/list/overview?referrer=search&project=eu-lab-mx006-dt643 when you click on "Connect" action
gcloud container clusters get-credentials gke-autopilot-cluster-eu-lab --region europe-west1 --project eu-lab-mx006-dt643

# Verify
kubectl config current-context
kubectl get pods
