#!/bin/bash
set -Eeuo pipefail

DOCKER_IMAGE=${DOCKER_IMAGE:-git.9wd.eu/felix/cloudron-surfer}
VERSION=$(grep cloudron-surfer Dockerfile | cut -d' ' -f 5 | cut -d@ -f 2)

# Function to check if a command is available
command_exists() {
	command -v "$1" >/dev/null 2>&1
}

if command_exists podman; then
	CMD="podman"
elif command_exists docker; then
	CMD="docker"
else
	echo "Error: Neither podman nor docker is installed."
	exit 1
fi

$CMD build . -t "$DOCKER_IMAGE:latest"
$CMD build . --target distrobox -t "$DOCKER_IMAGE:distrobox"

$CMD tag "$DOCKER_IMAGE:latest" "$DOCKER_IMAGE:$VERSION"

if [ "${1:-}" == "push" ]; then
	$CMD push "$DOCKER_IMAGE:latest"
	$CMD push "$DOCKER_IMAGE:$VERSION"
	$CMD push "$DOCKER_IMAGE:distrobox"
fi