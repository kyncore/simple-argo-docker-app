# Simple ArgoCD Docker App

This project demonstrates a simple CI/CD workflow using Docker and ArgoCD. It includes a "Hello World" backend service, a Dockerfile for containerization, and Kubernetes manifests for deployment.

## Prerequisites

- Docker Desktop with Kubernetes enabled
- kubectl
- ArgoCD

## How to Run with Docker Desktop

1.  **Enable Kubernetes in Docker Desktop:**
    - Open Docker Desktop settings.
    - Go to the "Kubernetes" tab.
    - Check the "Enable Kubernetes" box and click "Apply & Restart".
    - Ensure that `docker-desktop` is the current context for `kubectl` by running:
      ```bash
      kubectl config use-context docker-desktop
      ```

2.  **Build the Docker image:**
    This command builds the Docker image and tags it as `simple-argo-docker-app:latest`. Docker Desktop's Kubernetes can directly use images built by the Docker Desktop daemon.
    ```bash
    make build
    ```

3.  **Install ArgoCD:**
    ```bash
    kubectl create namespace argocd
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    ```

4.  **Deploy the application using ArgoCD:**
    This command creates the ArgoCD application, which will then automatically sync the manifests from your Git repository and deploy them to your Docker Desktop Kubernetes cluster.
    ```bash
    kubectl apply -f argocd/application.yaml
    ```

5.  **Check the application status in ArgoCD:**
    You can view the application's status in the ArgoCD UI.
    - **Access the ArgoCD UI:**
        ```bash
        kubectl port-forward svc/argocd-server -n argocd 8080:443
        ```
    - **Get the initial admin password:**
        ```bash
        kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
        ```
    - Open a web browser and navigate to `https://localhost:8080`. Log in with the username `admin` and the password you just retrieved.

6.  **Access your application:**
    Once the application is deployed and running (shows as "Healthy" and "Synced" in ArgoCD), you can access it by forwarding its port.
    ```bash
    kubectl port-forward svc/simple-argo-docker-app-service 8081:80
    ```
    Now, open your web browser and navigate to `http://localhost:8081` to see the "Hello World!" message.
