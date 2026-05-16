# voice

A compact GitHub home for the Dograh standalone bundle, install scripts, and workflow import/export notes.

## What’s in here
- `release/` — standalone Docker bundle
- `install-mac.sh` — one-command Mac installer
- `dograh_standalone_plan.md` — rollout plan
- `dograh_install_and_operate_guide.md` — install/operate runbook
- `dograh_internal_sell_in_debt_collection.md` — internal adoption note
- `dograh_workflow_import_export.md` — workflow import/export behavior and JSON shapes

## Quick start
- Open `release/` for the local Docker bundle.
- Run `./install-mac.sh` on macOS.
- Read `dograh_workflow_import_export.md` for workflow migration details.

## Notes
- The bundle is meant for local testing first.
- Pin image digests before production use.
- Keep secrets out of git.
