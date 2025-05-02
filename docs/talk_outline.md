# Level up your developer experience with Kubernetes

Content from the PyConZA 2024 presentation, covering:

## 1. Introduction
- Overview of the talk's goal: enhancing developer experience using Kubernetes
- Demo focus: bootstrapping a Django app with Postgres and Redis
- Credit to Roché Compaan for the original talk

## 2. The Developer Experience Challenge
- Common pain points in development environments
- Inconsistent environments across team members
- Slow onboarding for new developers
- Difficulty maintaining parity between environments

## 3. Why Containerized, Declarative Approaches
- Consistency and Reproducibility
- Declarative Infrastructure and Self-Healing
- Scalability and Efficiency
- Improved Collaboration and Version Control
- Enhanced Developer Experience
- Portability and Vendor Neutrality

## 4. Kubernetes Fundamentals
- What is Kubernetes?
- Declarative deployments using manifests
- Standardizing deployment across environments
- Benefits for both developers and DevOps teams

## 5. Tooling to Level Up Developer Experience
- Kind: Local Kubernetes clusters in Docker
- Tilt: Streamlining development workflow with live updates
- Scaf: Project bootstrapping and Kustomize layers
- Direnv and Nix: Environment management
- k9s: Kubernetes exploration and debugging

## 6. Deep Dive: Scaf and Python-Specific Workflow
- How Scaf generates project structure with Kubernetes manifests
- Django integration with Postgres and Redis
- Comparison with traditional Docker Compose setups
- The "git clone && make up" developer experience

## 7. Demo
- Repository walkthrough (app, k8s, docs directories)
- Key files (README.md, Makefile, Tiltfile)
- Starting the local cluster with Kind
- Using Tilt for development
- Interacting with the system (logs, k9s)

## 8. Conclusion and Q&A
- Recap of benefits
- How this approach improves productivity and consistency
- Resources for further learning
