#!/bin/bash

# --- 0. Change Directory to Script Location ---
cd "$(dirname "$0")/.."

# --- 1. Terminate Background Processes ---
# This kills the tunnel and port-forwarding processes started by start_project.sh.
echo "Stopping Minikube Tunnel and Port-Forwarding..."
# Using pkill to terminate processes by their command name
sudo pkill -f "minikube tunnel"
pkill -f "kubectl port-forward"

# --- 2. Remove Kubernetes Resources ---
# Deletes Deployment, Service, HPA, and Ingress to ensure a clean state.
echo "Removing Kubernetes manifests..."
kubectl delete -f k8s/.

# --- 3. Stop Minikube ---
# Shuts down the local cluster to free up system memory (RAM).
echo "Shutting down Minikube cluster..."
minikube stop

# --- 4. Final Status ---
echo "--------------------------------------------------"
echo "Project stopped successfully."
echo "Note: You may now close Docker Desktop to save additional resources."
echo "--------------------------------------------------"