{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    kind
    kubectl
    kubernetes-helm
    tilt
    k9s
    python3
    python3Packages.pip
    python3Packages.django
    python3Packages.psycopg2
    python3Packages.redis
    git
  ];

  shellHook = ''
    echo "Dev environment loaded!"
    echo "Use 'make up' to start the environment"
  '';
}
