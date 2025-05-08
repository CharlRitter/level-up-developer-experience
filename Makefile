.PHONY: up down clean logs setup

setup:
		@echo "Setting up development environment..."

		@echo "Checking and installing required tools..."
		@if ! command -v docker &> /dev/null; then \
				echo "Installing Docker Desktop..."; \
				brew install --cask docker || true; \
		else \
				echo "Docker already installed"; \
		fi

		@for tool in kind kubectl tilt direnv k9s; do \
				if ! command -v $$tool &> /dev/null; then \
						echo "Installing $$tool..."; \
						brew install $$tool; \
				else \
						echo "$$tool already installed"; \
				fi \
		done

		@if ! command -v nix &> /dev/null; then \
				echo "Installing Nix package manager..."; \
				curl -L https://nixos.org/nix/install | sh; \
		else \
				echo "Nix already installed"; \
		fi

		@echo "Setting up direnv in your shell..."
		@if [ -f "$$HOME/.zshrc" ]; then \
				grep -q "direnv hook zsh" $$HOME/.zshrc || echo 'eval "$$(direnv hook zsh)"' >> $$HOME/.zshrc; \
				echo "Added direnv to zsh."; \
				@direnv allow; \
		elif [ -f "$$HOME/.bashrc" ]; then \
				grep -q "direnv hook bash" $$HOME/.bashrc || echo 'eval "$$(direnv hook bash)"' >> $$HOME/.bashrc; \
				echo "Added direnv to bash."; \
				@direnv allow; \
		else \
				echo "You're not using zsh or bash. Please manually add direnv hook to your shell."; \
				echo "For fish: echo 'direnv hook fish | source' and run 'direnv allow"; \
		fi || true

		@echo "Setup complete!"

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
