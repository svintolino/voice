#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RELEASE_DIR="${REPO_DIR}/release"

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker Desktop is required. Install it from https://www.docker.com/products/docker-desktop/" >&2
  exit 1
fi

if ! docker compose version >/dev/null 2>&1; then
  echo "Docker Compose plugin is required." >&2
  exit 1
fi

cd "${RELEASE_DIR}"

if [ ! -f .env ]; then
  cp .env.example .env
fi

if grep -q "REPLACE_ME" docker-compose.standalone.yaml; then
  echo "Warning: image digests still contain placeholders. This is fine for a first local test, but not production." >&2
fi

# Local Mac first-run defaults
: "${ENABLE_TELEMETRY:=false}"
: "${DOGRAH_VERSION:=latest}"

sed -i.bak "s/^ENABLE_TELEMETRY=.*/ENABLE_TELEMETRY=${ENABLE_TELEMETRY}/" .env || true
sed -i.bak "s/^DOGRAH_VERSION=.*/DOGRAH_VERSION=${DOGRAH_VERSION}/" .env || true
rm -f .env.bak

# Keep this local-only for the first test
sed -i.bak "s|^MINIO_PUBLIC_ENDPOINT=.*|MINIO_PUBLIC_ENDPOINT=http://localhost:9000|" .env || true
rm -f .env.bak

docker compose -f docker-compose.standalone.yaml --env-file .env pull
docker compose -f docker-compose.standalone.yaml --env-file .env up -d

echo
 echo "Dograh is starting on your Mac. Open http://localhost:13010 after a minute or two."
 echo "If you want, run: cd release && ./verify-install.sh"
