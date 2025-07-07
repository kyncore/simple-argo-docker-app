# Simple ArgoCD Docker App

This project demonstrates a simple CI/CD workflow using Docker and ArgoCD. It includes a "Hello World" backend service, a Dockerfile for containerization, and Kubernetes manifests for deployment.

## Prerequisites

- Docker
- Minikube
- kubectl
- ArgoCD

## Local Development

To run the application locally, you will need to have Docker and Minikube installed.

1. **Start Minikube:**
   ```bash
   minikube start
   ```

2. **Build the Docker image:**
   ```bash
   make build
   ```

3. **Deploy the application:**
   ```bash
   make deploy
   ```

4. **Access the application:**
   ```bash
   minikube service simple-argo-docker-app-service
   ```

## ArgoCD Setup

1. **Install ArgoCD:**
   ```bash
   kubectl create namespace argocd
   kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
   ```

2. **Access the ArgoCD UI:**
   ```bash
   kubectl port-forward svc/argocd-server -n argocd 8080:443
   ```

3. **Get the initial admin password:**
   ```bash
   kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
   ```

4. **Create the ArgoCD application:**
   ```bash
   kubectl apply -f argocd/application.yaml
   ```
