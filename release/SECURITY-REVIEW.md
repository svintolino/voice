# Dograh Security Review Notes

## Purpose
This bundle is intended to be inspectable, reproducible, and suitable for IT/security review before production use.

## What is included
- Docker Compose deployment for API, UI, Postgres, Redis, MinIO, and cloudflared
- optional TURN support through the upstream application settings
- Azure OpenAI configuration via environment variables
- optional Langfuse tracing

## What is not included
- no external SaaS dependency is required for local mode beyond Docker image pulls
- no embedded carrier credentials
- no hard-coded enterprise secrets

## Verification items
- confirm image digests are pinned before production
- review `.env` for secrets and tenant-specific URLs
- confirm `ENABLE_TELEMETRY=false` for regulated environments
- confirm port exposure only on localhost for local installs
- confirm the public deployment uses HTTPS and firewall restrictions
- confirm call recordings, logs, and transcripts follow retention policy

## Data flows to review
- inbound/outbound call audio to the selected telephony provider
- audio and transcripts through STT/TTS/LLM services
- recordings and assets stored in MinIO or approved object storage
- optional analytics to Langfuse if enabled

## Control recommendations
- store secrets in a vault or Docker secrets in production
- pin all images to immutable digests
- keep a change log of telephony provider and workflow changes
- restrict admin access to trusted operators only
- keep a rollback version available

## Validation checklist
- run the verification script after install
- complete one web call test
- complete one inbound test call
- complete one outbound test call
- verify logs and recordings are accessible only to authorized users
- verify deletion/retention flows before live rollout
