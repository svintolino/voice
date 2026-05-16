#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${ROOT_DIR}"

if ! command -v docker >/dev/null 2>&1; then
  echo "docker is required" >&2
  exit 1
fi

if ! docker compose version >/dev/null 2>&1; then
  echo "docker compose plugin is required" >&2
  exit 1
fi

if [ ! -f .env ]; then
  cp .env.example .env
  echo "Created .env from .env.example"
fi

if grep -q 'REPLACE_ME' docker-compose.yml; then
  echo "Warning: image digests still contain REPLACE_ME placeholders." >&2
  echo "Pin the release digests before production use." >&2
fi

docker compose -f docker-compose.yml --env-file .env pull

docker compose -f docker-compose.yml --env-file .env up -d

echo "Dograh is starting. Open the UI at http://localhost:3010 once healthy."
