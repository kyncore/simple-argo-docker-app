.PHONY: build deploy

build:
	docker build -t simple-argo-docker-app:latest .

deploy:
	kubectl apply -f k8s/
