
# Level Up Your Developer Experience

This repository demonstrates how to quickly bootstrap a full development environment using Kubernetes and a set of modern tools, including Scaf, Kind, Tilt, Direnv, and Nix. It accompanies my talk presenting Roché Compaan's _"Level Up Your Developer Experience with Kubernetes"_ talk, which was presented at PyConZA 2024.

## Overview

The project deploys a Django application configured with a Postgres backend and a Redis cache. The Kubernetes manifests are organized with Kustomize overlays for different environments (development, staging, production). The demo shows how to obtain a reproducible, containerized development environment with a single command.

## Prerequisites

- [Kind](https://kind.sigs.k8s.io)
- [Tilt](https://tilt.dev)
- [Direnv](https://direnv.net)
- [Nix](https://nixos.org)
- [k9s](https://k9scli.io)
- [Scaf](https://github.com/sixfeetup/scaf/) - For project bootstrapping
- Docker

### Installing Prerequisites

```bash
# Install Docker Desktop, Kind, Kubectl, Tilt, Direnv, and k9s
brew install --cask docker
brew install kind kubectl tilt direnv k9s

# Install Nix package manager
sh <(curl -L https://nixos.org/nix/install)

# Set up direnv in your shell (if using zsh)
echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc
source ~/.zshrc

# Install Scaf (For project bootstrapping only)
pip install scaf
```

## Using Scaf for New Projects

```bash
# Install scaf
curl -sSL https://raw.githubusercontent.com/sixfeetup/scaf/main/install.sh | bash

# Create a new project
scaf init my-new-project --template template-name

# Navigate to the new project
cd my-new-project

# Follow the README instructions
```

## Quick Start

```bash
git clone https://github.com/CharlRitter/level-up-developer-experience.git
cd level-up-developer-experience
direnv allow
make up
```

## Working with the Environment

Exploring with k9s

After starting the environment:
```bash
k9s
```

This will open an interactive terminal UI to explore your Kubernetes cluster.

Viewing Logs
```bash
make logs
```
Cleaning Up
```bash
make clean
```

## Repository Structure

```
/level-up-developer-experience
 ├── README.md
 ├── Makefile
 ├── Tiltfile
 ├── .envrc
 ├── shell.nix
 ├── k8s/
 │ ├── base/
 │ │ ├── django-deployment.yaml
 │ │ ├── django-service.yaml
 │ │ ├── configmap.yaml
 │ │ ├── postgres-deployment.yaml
 │ │ ├── postgres-service.yaml
 │ │ ├── redis-deployment.yaml
 │ │ └── redis-service.yaml
 │ └── overlays/
 │ ├── development/
 │ │ └── kustomization.yaml
 │ ├── staging/
 │ │ └── kustomization.yaml
 │ └── production/
 │ └── kustomization.yaml
 ├── app/
 │ ├── Dockerfile
 │ ├── manage.py
 │ ├── requirements.txt
 │ └── myproject/
 │    ├── \_\_init\_\_.py
 │    ├── settings.py
 │    ├── urls.py
 │    └── wsgi.py
 └── docs/
 │ └── talk_outline.md
 │ └── talk_slides.md
```

## Why Containerized, Declarative Approach

Our approach provides several benefits for developer experience:

- **Consistency and Reproducibility**: Containers ensure uniform environments and immutable artifacts across all stages
- **Declarative Infrastructure and Self-Healing**: Define desired state in YAML manifests and let Kubernetes maintain it
- **Scalability and Efficiency**: Easily adjust resources and scale applications as needed
- **Improved Collaboration**: Infrastructure as code enables version control and peer review of configurations
- **Enhanced Developer Experience**: Rapid feedback loops, streamlined onboarding, and cross-environment consistency
- **Portability and Vendor Neutrality**: Run anywhere containers are supported with minimal vendor lock-in

## Kustomize Overlays

This project uses Kustomize to manage environment-specific configurations:

- **Base Layer**: Contains core resources shared across all environments
- **Development Overlay**: Used for local development with debugging enabled
- **Staging Overlay**: Mirrors production setup but in an isolated namespace
- **Production Overlay**: Production-ready configuration

Kustomize allows us to maintain a single source of truth while adapting configurations for different environments without duplication.

## CI/CD and Preview Environments

The repository includes GitHub Actions workflows that:

1. Run tests for all branches and pull requests
2. Automatically deploy preview environments for pull requests
3. Allow testing changes in isolation before merging

To explore the CI/CD configuration, see [.github/workflows/preview-environment.yml](./.github/workflows/preview-environment.yml).

 ## Benefits

- Consistent Development: Every developer gets the same environment
- Quick Onboarding: New team members can get up and running in minutes
- Environment Parity: Development setup closely matches production
- Live Updates: Changes immediately reflected in the running application

## Supporting documents

For an overview of the talk outline, see [docs/talk_outline.md](./docs/talk_outline.md) and for the slides see [docs/talk_slides.md](./docs/talk_slides.md).
