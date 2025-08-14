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
gcloud container clusters get-credentials gke-autopilot-cluster-eu-lab  --region europe-west1         --project eu-lab-mx006-dt643
gcloud container clusters get-credentials gke-autopilot-cluster-au-test --region australia-southeast1 --project au-test-mx006-dt643
gcloud container clusters get-credentials gke-autopilot-cluster-au-prod --region australia-southeast1 --project au-prod-mx006-dt644
gcloud container clusters get-credentials gke-autopilot-cluster-eu-test --region europe-west1         --project eu-test-mx006-dt644
gcloud container clusters get-credentials gke-autopilot-cluster-eu-prod --region europe-west1         --project eu-prod-mx006-dt644
gcloud container clusters get-credentials gke-autopilot-cluster-us-test --region us-central1          --project us-test-mx006-dt644
gcloud container clusters get-credentials gke-autopilot-cluster-us-prod --region us-central1          --project us-prod-mx006-dt644

# Give the contexts simpler names:
kubectl config rename-context gke_eu-lab-mx006-dt643_europe-west1_gke-autopilot-cluster-eu-lab           gke-eu-lab
kubectl config rename-context gke_eu-test-mx006-dt644_europe-west1_gke-autopilot-cluster-eu-test         gke-eu-test
kubectl config rename-context gke_eu-prod-mx006-dt644_europe-west1_gke-autopilot-cluster-eu-prod         gke-eu-prod
kubectl config rename-context gke_au-test-mx006-dt643_australia-southeast1_gke-autopilot-cluster-au-test gke-au-test
kubectl config rename-context gke_au-prod-mx006-dt644_australia-southeast1_gke-autopilot-cluster-au-prod gke-au-prod
kubectl config rename-context gke_us-test-mx006-dt644_us-central1_gke-autopilot-cluster-us-test          gke-us-test
kubectl config rename-context gke_us-prod-mx006-dt644_us-central1_gke-autopilot-cluster-us-prod          gke-us-prod

# "Verify"
kubectl config get-contexts
kubectl get pods
