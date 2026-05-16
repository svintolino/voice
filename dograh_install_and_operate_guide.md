# Dograh Install and Operate Guide

## 1. What this is
A Docker-based self-hosted voice agent platform for inbound and outbound calling.

## 2. Prerequisites
### macOS
- Docker Desktop installed
- `curl` installed
- a browser for the UI

### Ubuntu
- Docker Engine + Docker Compose plugin
- `curl`
- enough resources for voice workloads

### Recommended baseline
- 4 vCPU minimum
- 8 GB RAM minimum
- 50+ GB disk depending on recordings and logs
- public hostname if you want inbound calling in production

## 3. Download the standalone package
Use the release bundle you distribute internally, or clone the repo and pin a known commit.

Example structure:
- `docker-compose.standalone.yaml`
- `.env`
- `install.sh`
- `verify-install.sh`
- `RUNBOOK.md`

## 4. First install
### Local evaluation on Mac or Ubuntu
1. Unpack the bundle into a working directory.
2. Copy `.env.example.standalone` to `.env`.
3. Set `ENABLE_TELEMETRY=false` for security review mode.
4. Set any required Azure OpenAI variables.
5. Start the stack with Docker Compose.
6. Open the UI in the browser.
7. Make a browser/web call first before connecting a carrier.

### Production remote install on Ubuntu
1. Provision the server.
2. Install Docker and Compose.
3. Point DNS at the server.
4. Obtain TLS certificates or use the provided HTTPS path.
5. Set `PUBLIC_BASE_URL`.
6. Set `MINIO_PUBLIC_ENDPOINT` to the public HTTPS URL.
7. Set TURN settings if users will connect from browsers behind NAT/firewalls.
8. Start the stack.

## 5. Core configuration
### Required
- database
- redis
- object storage / MinIO or S3
- backend public URL
- UI public URL
- JWT secret
- telephony provider credentials

### Azure OpenAI
Set the model provider configuration in the UI or via API to Azure.
You will need:
- endpoint
- API key
- deployment/model name
- API version if the UI/API requests it

### Telephony
Create one telephony config per carrier relationship or per country route.
- set the config as default outbound if it should be the fallback caller ID
- attach phone numbers
- bind inbound workflows to the numbers that should answer calls

## 6. How to test
### Web call test
1. Open the dashboard.
2. Create a simple inbound or outbound workflow.
3. Use web call to confirm STT, LLM, and TTS.

### Inbound call test
1. Buy or provision a test number.
2. Attach it to a telephony configuration.
3. Bind the inbound workflow to that number.
4. Call the number from a mobile phone.
5. Confirm transcript, recording, and call logs.

### Outbound call test
1. Set a default outbound caller ID.
2. Trigger a call from the UI or API.
3. Verify the call arrives, the script starts, and the logs are written.

## 7. Maintenance
### Daily
- check `/api/v1/health`
- review failed call logs
- confirm provider webhook deliveries
- inspect storage and disk use

### Weekly
- review call quality and script failures
- check provider account balance and number status
- test one inbound and one outbound call
- verify backups exist

### Monthly
- patch host OS and Docker
- pull new images into staging first
- review retention and deletion policies
- rotate secrets if policy requires it

## 8. Updates
Recommended update flow:
1. Stage the new version in a test environment.
2. Run one inbound and one outbound test call.
3. Check health, logs, and workflow history.
4. Promote to production.
5. Keep the previous image set for rollback.

## 9. Rollback
If the new version fails:
1. Stop the new containers.
2. Restore the previous image tags.
3. Restart the stack.
4. Confirm health and a test call.

## 10. Backup and restore
Back up:
- database
- MinIO/object storage
- `.env`
- any custom workflow exports

Restore order:
1. database
2. object storage
3. app containers
4. verify health
5. verify a call

## 11. Security notes
- do not expose admin ports publicly unless required
- keep telemetry off until approved
- use HTTPS for browser mic access and provider callbacks
- store secrets outside git
- restrict access to call recordings and transcripts

## 12. What IT security will ask
Prepare answers for:
- where data flows
- which third parties receive audio/text
- where recordings live
- how long logs persist
- who can access transcripts
- how secrets are stored
- how to disable or delete a tenant
- how to verify the build came from source

## 13. Country/provider setup template
For each country, fill in:
- local DID available: yes/no
- outbound CLI allowed: yes/no
- recording consent method
- retention period
- language script
- fallback provider
- support contact

## 14. Keep the system usable
- keep one “known good” workflow template for collections
- keep one “test” number separate from live operations
- keep one “superuser” credential path locked down
- keep a changelog of all telephony and prompt changes
