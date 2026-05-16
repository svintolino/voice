# Dograh Standalone Docker Plan

## What you asked for
A standalone Docker-based package for `dograh` that can be downloaded and installed on macOS or Ubuntu, with:
- inbound and outbound calling
- Azure tenant support for OpenAI
- a transparent, verifiable setup suitable for IT security review
- a how-to guide for providers in DK, DE, SE, NO, and FI
- installation, maintenance, and internal adoption guidance for a debt collection organization

## What the source already supports
From the repo and docs, Dograh already has most of the building blocks:
- Docker-first deployment
- Inbound and outbound telephony
- Provider abstraction for Twilio, Vonage, Telnyx, Plivo, Cloudonix, Vobiz, and Asterisk ARI
- Azure as an LLM provider
- WebRTC / TURN support for browser calling
- API access for workflows, telephony configs, recordings, usage, and health

## Gaps to close for a true standalone package
1. Packaging clarity
   - The repo has a compose file, but not yet a polished downloadable "installer bundle".
   - Add a slim release package with a pinned compose file, `.env.example`, startup scripts, and a verification checklist.

2. Security hardening
   - Telemetry defaults should be opt-out or disabled for regulated buyers.
   - Secrets should move to `.env` or Docker secrets, not inline defaults.
   - Remote deployment should default to HTTPS and explicit host binding.

3. Operator experience
   - Add a step-by-step install, test call, provider setup, update, rollback, and backup guide.
   - Add a troubleshooting section for certificate, webhook, media, and NAT issues.

4. Commercial fit for debt collection
   - Add scripts and guidance for compliant use cases only: payment reminder, promise-to-pay, routing, FAQ, and callback scheduling.
   - Include human handoff rules, call recording policy, and audit logging.

## Recommended packaging approach
Use a two-mode deliverable:

### Mode A: Local evaluation package
For Mac/Ubuntu developers and security reviewers.
- `docker compose up` on localhost
- self-signed TLS for browser mic permissions where needed
- no public exposure
- telemetry disabled by default

### Mode B: Production remote package
For a locked-down Ubuntu server.
- reverse proxy with HTTPS
- TURN enabled
- firewall restricted to only needed ports
- secrets in environment file or secret store
- provider webhooks and callback URLs on a real domain

## Suggested repository additions
Create a small release bundle with:
- `docker-compose.standalone.yaml`
- `.env.example.standalone`
- `install.sh`
- `install.ps1` or `install-macos.sh` if you want a macOS helper
- `verify-install.sh`
- `RUNBOOK.md`
- `SECURITY-REVIEW.md`
- `PROVIDER-GUIDE.md`
- `DEBT-COLLECTION-SALES-README.md`

## Telephony strategy for DK, DE, SE, NO, FI
Use this order of preference:
1. Telnyx for primary PSTN coverage where local number/regulatory support is strongest.
2. Twilio as the broad fallback / fastest operational baseline.
3. Vonage as a secondary option where account or routing fit is better.
4. Asterisk ARI for enterprises that want BYOC / SIP trunking / local carrier integration.
5. Cloudonix or Vobiz where a local provider relationship or specific country routing makes sense.

For each country, the real decision is not just provider brand; it is:
- local DID availability
- outbound CLI rules
- local presence / display number policy
- consent and recording rules
- number registration and proof of use
- porting support

## Country guidance at a high level
These should be treated as procurement/compliance checkpoints, not legal advice.

### Denmark (DK)
- Expect local DID and caller ID verification requirements.
- Prefer a provider with clear number provisioning docs and support for voice webhooks.
- Validate call recording notice language and retention rules before pilot.

### Germany (DE)
- Expect stricter privacy and recording sensitivity.
- Use explicit consent, short retention, and German-language call scripts.
- Validate whether you can legally and technically present local caller ID and whether recording is allowed for the use case.

### Sweden (SE)
- Focus on local number availability and consent-based outbound practices.
- Make sure the operator workflow includes clear identification and opt-out handling.

### Norway (NO)
- Validate local number support and outbound presentation rules.
- Make sure your script and callback handling are consistent with privacy expectations.

### Finland (FI)
- Confirm local number / geographic presentation support.
- Keep scripts concise and deterministic for collections and callback routing.

## Azure OpenAI recommendation
Use Azure OpenAI as the LLM backend for production when your enterprise already has an Azure tenant.

You will need:
- Azure subscription + resource group
- Azure OpenAI resource
- deployed model name(s)
- endpoint URL
- API key or managed identity flow if supported by your deployment pattern
- network egress allowed from Dograh to Azure endpoints

Recommended pattern:
- use Azure OpenAI for LLM
- keep STT/TTS either Dograh defaults or enterprise-approved providers
- turn on tracing only after legal/compliance review
- store Azure secrets in environment variables or secret manager

## Security / verifiability package for IT approval
To be approvable, the package should be easy to inspect and reproduce.

### Required controls
- pinned image tags, not `latest`
- published checksum or digest for released images
- source repo link and exact commit hash used for the release
- `.env.example` with every configurable value documented
- no hidden external services required for local mode
- logs exposed and retainable
- health endpoint documented
- clear data flow diagram
- clear secrets list
- firewall port list
- backup and restore steps
- rollback procedure

### Suggested evidence artifacts
- architecture diagram
- data flow diagram
- threat model summary
- dependency list / SBOM
- release manifest with image digests
- test-call procedure and expected output
- sample webhook payloads
- change log and version pinning policy

## Operator lifecycle
Daily:
- confirm health endpoint
- review failed calls and webhook errors
- check queue depth / campaign status
- review storage and disk usage

Weekly:
- rotate or review credentials if policy requires
- update images in a staging environment first
- inspect provider number status
- verify backups restore cleanly

Monthly:
- review call scripts
- review compliance language
- patch OS and Docker host
- check carrier/provider invoices and failed-call patterns

## Recommended rollout path
1. Local proof of concept on one laptop.
2. Security review on a locked-down Ubuntu VM.
3. Pilot with one geography and one provider.
4. Add second provider or backup route.
5. Expand to more countries after proving numbers, scripts, and compliance controls.

## Practical recommendation
Do not promise "one universal telephony provider for all five countries". Promise a single platform with country-specific carrier choices and a common workflow layer. That is the credible story.
