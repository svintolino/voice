# voice

A standalone Dograh release bundle for self-hosted voice-agent testing and rollout.

## What’s here
- `release/docker-compose.standalone.yaml` — pinned-friendly Docker Compose bundle
- `release/.env.example` — local configuration template
- `release/install.sh` — install/start helper
- `release/verify-install.sh` — smoke-test helper
- `release/SECURITY-REVIEW.md` — IT/security review checklist
- `dograh_standalone_plan.md` — implementation and rollout plan
- `dograh_install_and_operate_guide.md` — operator install/runbook
- `dograh_internal_sell_in_debt_collection.md` — internal adoption memo

## Quick start
1. Copy `release/.env.example` to `release/.env`.
2. Fill in the environment values you need.
3. Run `release/install.sh`.
4. Run `release/verify-install.sh`.
5. Open the UI on `http://localhost:3010`.

## Notes
- Replace placeholder image digests in `release/docker-compose.standalone.yaml` before production use.
- Keep telemetry disabled unless your policy approves it.
- For production, use HTTPS and a locked-down firewall.

## License
Dograh is BSD 2-Clause upstream; this bundle follows the upstream project structure and release notes.

## Dograh Workflow Import/Export
- See `dograh_workflow_import_export.md` for the workflow import/export behavior and supported JSON shapes.
