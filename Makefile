.PHONY: up down clean logs setup

setup:
		@echo "Installing Docker Desktop, Kind, Kubectl, Tilt, Direnv, and k9s..."
		brew install --cask docker
		brew install kind kubectl tilt direnv k9s

		@echo "Installing Nix package manager..."
		sh <(curl -L https://nixos.org/nix/install)

		@echo "Set up direnv in your shell (if using zsh)..."
		echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc
		source ~/.zshrc

up:
		@echo "Creating Kind cluster..."
		kind create cluster --name dev || true
		@echo "Starting Tilt..."
		tilt up

down:
		@echo "Stopping Tilt..."
		tilt down
		@echo "Cluster still running. Use 'make clean' to delete the cluster."

clean:
		@echo "Stopping Tilt..."
		tilt down || true
		@echo "Deleting Kind cluster..."
		kind delete cluster --name dev || true
		@echo "Environment cleaned up."

logs:
		@echo "Fetching logs from Django pod..."
		kubectl logs -l app=django -f

shell:
		@echo "Opening shell in Django pod..."
		kubectl exec -it $$(kubectl get pod -l app=django -o jsonpath='{.items[0].metadata.name}') -- /bin/bash

help:
		@echo "Available commands:"
		@echo "	make setup	- Install prerequisites"
		@echo "	make up			- Create cluster and start Tilt"
		@echo "	make down		- Stop Tilt but keep the cluster"
		@echo "	make clean	- Stop Tilt and delete the cluster"
		@echo "	make logs		- View Django application logs"
		@echo "	make shell	- Open a shell in the Django container"
