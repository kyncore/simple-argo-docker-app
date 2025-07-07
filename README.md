# Simple ArgoCD Docker App

This project demonstrates a simple CI/CD workflow using Docker and ArgoCD. It includes a "Hello World" backend service, a Dockerfile for containerization, and Kubernetes manifests for deployment.

## Prerequisites

- Docker
- Minikube
- kubectl
- ArgoCD

# Simple ArgoCD Docker App

This project demonstrates a simple CI/CD workflow using Docker and ArgoCD. It includes a "Hello World" backend service, a Dockerfile for containerization, and Kubernetes manifests for deployment.

## Prerequisites

- Docker
- Minikube
- kubectl
- ArgoCD

## How to Run Locally

1.  **Start Minikube:**
    ```bash
    minikube start
    ```

2.  **Set Docker environment:**
    Point your local Docker client to the Docker daemon inside Minikube. This is crucial for making the locally built image available to the Kubernetes cluster.
    ```bash
    eval $(minikube -p minikube docker-env)
    ```

3.  **Build the Docker image:**
    This command builds the Docker image and tags it as `simple-argo-docker-app:latest`.
    ```bash
    make build
    ```

4.  **Install ArgoCD:**
    ```bash
    kubectl create namespace argocd
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    ```

5.  **Deploy the application using ArgoCD:**
    This command creates the ArgoCD application, which will then automatically sync the manifests from your Git repository and deploy them to the Minikube cluster.
    ```bash
    kubectl apply -f argocd/application.yaml
    ```

6.  **Check the application status in ArgoCD:**
    You can view the application's status in the ArgoCD UI.
    - **Access the ArgoCD UI:**
        ```bash
        kubectl port-forward svc/argocd-server -n argocd 8080:443
        ```
    - **Get the initial admin password:**
        ```bash
        kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
        ```
    - Open a web browser and navigate to `http://localhost:8080`. Log in with the username `admin` and the password you just retrieved.

7.  **Access the application:**
    Once the application is deployed and running, you can access it using the following command:
    ```bash
    minikube service simple-argo-docker-app-service
    ```
