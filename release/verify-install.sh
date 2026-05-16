#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${ROOT_DIR}"

if [ ! -f .env ]; then
  echo ".env missing" >&2
  exit 1
fi

services=(postgres redis minio cloudflared api ui)

docker compose -f docker-compose.yml --env-file .env ps

for svc in "${services[@]}"; do
  status="$(docker compose -f docker-compose.yml --env-file .env ps --format json "$svc" 2>/dev/null || true)"
  echo "Checked ${svc}: ${status:-unknown}"
done

curl -fsS http://localhost:18000/api/v1/health >/dev/null
curl -fsS http://localhost:13010 >/dev/null

echo "Health checks passed."
