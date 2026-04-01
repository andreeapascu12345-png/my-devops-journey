#!/bin/bash

# --- 0. Change Directory to Script Location ---
# This ensures that 'kubectl apply -f .' finds your yaml files
cd "$(dirname "$0")/.."

# --- 1. Start Minikube Cluster ---
# Ensure Docker Desktop is already running on Windows.
echo " Starting Minikube..."
minikube start --memory 4096 --cpus 2

# --- 2. Apply Kubernetes Manifests ---
# This ensures all your components (Deployment, Service, HPA, Ingress) 
# are created or updated according to your YAML files.
echo " Applying Kubernetes manifests..."
kubectl apply -f k8s/.
kubectl rollout status deployment/devops-journey-deployment -n web-app-devops

# --- 3. Set up Port-Forwarding for Monitoring ---
# Forwarding Grafana dashboard to localhost:3000.
echo " Setting up Port-Forward for Grafana..."
kubectl port-forward deployment/my-monitor-grafana 3000:3000 > /dev/null 2>&1 &

# --- 4. Enable Ingress Tunnel ---
# Required for webapp.local to work on Windows/WSL2.
echo " Activating Minikube Tunnel (might ask for sudo password)..."
minikube tunnel 

# --- 5. Final Status ---
echo "--------------------------------------------------"
echo " Everything is up and running!"
echo " App URL:     http://webapp.local"
echo " Grafana URL: http://localhost:3000"
echo "--------------------------------------------------"
echo "Press Ctrl+C to stop the tunnel and port-forwarding."

# Wait for background processes
wait
