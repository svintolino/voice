# validate_call

Simple local setup for testing caller identity verification in Dograh.

## Artifacts
- `verify_identity_server.py` — tiny local HTTP backend
- `dograh_identity_verification_local.json` — importable workflow
- `dograh_identity_verification_setup.md` — tool setup notes

## Start the backend
```bash
cd validate_call
python3 verify_identity_server.py
```

It listens on:
- `http://127.0.0.1:8787`

## Verify it works
```bash
curl -s http://127.0.0.1:8787/api/identity/verify \
  -H 'Content-Type: application/json' \
  -d '{"full_name":"Joe Black","id_number":"123456"}'
```

Expected:
```json
{"status": "verified"}
```

## Dograh tool config
Point the HTTP tool at:
- `http://127.0.0.1:8787/api/identity/verify`

Use JSON fields:
- `full_name`
- `id_number`

## Import workflow
Import:
- `dograh_identity_verification_local.json`

Then replace:
- `VERIFY_TOOL_UUID_HERE`

with the tool UUID created in Dograh.

## Real live test flow
1. Start the backend.
2. Create the Dograh HTTP tool.
3. Import the workflow.
4. Attach the tool UUID to both workflow nodes.
5. Run a test call.
6. Use `Joe Black` / `123456` to hit the verified branch.
7. Use any other values to hit fallback.
