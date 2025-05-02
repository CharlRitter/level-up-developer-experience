# Load environment setup
load('ext://namespace', 'namespace_create')
namespace_create('development')

# Load the restart_process extension
load('ext://restart_process', 'docker_build_with_restart')

# Build Docker image with restart process instead of restart container
docker_build_with_restart(
    'django-app',
    './app',
    dockerfile='./app/Dockerfile',
    entrypoint=['gunicorn', 'myproject.wsgi:application', '--bind', '0.0.0.0:8000'],
    live_update=[
        sync('./app', '/app'),
        run('pip install -r requirements.txt', trigger=['./app/requirements.txt']),
    ]
)

# Apply Kubernetes configs
k8s_yaml(kustomize('./k8s/overlays/development'))

# Port forwards for local access
k8s_resource(
    'django-deployment',
    port_forwards=['8000:8000'],
    labels=["app"],
    links=[link('http://localhost:8000', 'Django App')]
)

k8s_resource(
    'postgres-deployment',
    port_forwards=['5432:5432'],
    labels=["database"]
)

k8s_resource(
    'redis-deployment',
    port_forwards=['6379:6379'],
    labels=["cache"]
)

# Show intro message
print("""
🚀 Welcome to the Level Up Your Developer Experience Demo!

Your development environment is starting up:
- Django app will be available at http://localhost:8000
- Postgres is exposed on localhost:5432
- Redis is exposed on localhost:6379

Use k9s to explore your cluster or run 'make logs' to see application logs.
""")
