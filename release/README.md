# Dograh Standalone Release Bundle

This folder contains a pinned-friendly, security-reviewable release bundle for Dograh.

## Files
- `docker-compose.standalone.yaml` — release compose file
- `.env.example` — local copy template
- `install.sh` — install/start helper
- `verify-install.sh` — basic health verification
- `SECURITY-REVIEW.md` — IT/security checklist

## Quick start
```bash
cp .env.example .env
./install.sh
./verify-install.sh
```

## Notes
- Replace placeholder image digests with published immutable digests before production use.
- Keep `ENABLE_TELEMETRY=false` unless your policy explicitly allows it.
- For production, use HTTPS, a real domain, and restricted firewall rules.
- For Azure OpenAI, fill in the `AZURE_OPENAI_*` values in `.env`.

## Recommended next step
Add a release script that rewrites `REPLACE_ME` with verified digests from your CI pipeline.
