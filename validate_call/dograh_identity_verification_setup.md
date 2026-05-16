# Dograh Identity Verification Setup

## 1) Create this HTTP API tool in Dograh

- **Name:** `Verify Identity`
- **Description:** `Verify caller name plus national ID/SSN-equivalent against the backend source of truth.`
- **Category:** `http_api`
- **Icon:** `shield`
- **Color:** `#0EA5E9`
- **Definition:**
```json
{
  "schema_version": 1,
  "type": "http_api",
  "config": {
    "method": "POST",
    "url": "https://verification.example.com/api/identity/verify",
    "headers": {
      "Content-Type": "application/json"
    },
    "parameters": [
      { "name": "full_name", "type": "string", "description": "Caller full legal name", "required": true },
      { "name": "id_number", "type": "string", "description": "National ID or SSN-equivalent", "required": true }
    ],
    "timeout_ms": 5000,
    "customMessage": "Verification completed.",
    "customMessageType": "text"
  }
}
```

## 2) Import this workflow JSON

```json
{
  "name": "Identity Verification Intake",
  "workflow_definition": {
    "nodes": [
      {
        "id": "start-1",
        "type": "startCall",
        "position": { "x": 180, "y": 180 },
        "data": {
          "name": "Start Call",
          "greeting_type": "text",
          "greeting": "Hi, this is the automated assistant. Before we continue, I need to verify your identity.",
          "prompt": "Ask for the caller's full name and national ID or SSN-equivalent. Do not discuss account details yet. If the caller refuses, offer a human transfer or callback.",
          "allow_interrupt": true,
          "add_global_prompt": true,
          "extraction_enabled": true,
          "extraction_prompt": "Extract the caller's full name and national ID / SSN-equivalent. Do not extract extra sensitive information.",
          "extraction_variables": [
            { "name": "caller_full_name", "type": "string", "prompt": "Caller's full legal name" },
            { "name": "caller_id_number", "type": "string", "prompt": "Caller's national ID or SSN-equivalent" }
          ],
          "tool_uuids": ["VERIFY_TOOL_UUID_HERE"],
          "document_uuids": []
        }
      },
      {
        "id": "agent-verify-1",
        "type": "agentNode",
        "position": { "x": 520, "y": 180 },
        "data": {
          "name": "Verify Identity",
          "prompt": "Use the verification tool with the extracted full name and ID number. If verified, continue to the account discussion branch. If not verified or needs review, keep the conversation generic and do not disclose account details.",
          "allow_interrupt": true,
          "add_global_prompt": true,
          "extraction_enabled": false,
          "tool_uuids": ["VERIFY_TOOL_UUID_HERE"],
          "document_uuids": []
        }
      },
      {
        "id": "agent-verified-1",
        "type": "agentNode",
        "position": { "x": 860, "y": 120 },
        "data": {
          "name": "Verified Branch",
          "prompt": "The caller has been verified. You may now discuss account details, payment options, and next steps.",
          "allow_interrupt": true,
          "add_global_prompt": true,
          "extraction_enabled": false,
          "tool_uuids": [],
          "document_uuids": []
        }
      },
      {
        "id": "agent-fallback-1",
        "type": "agentNode",
        "position": { "x": 860, "y": 300 },
        "data": {
          "name": "Fallback Branch",
          "prompt": "Identity could not be verified. Do not disclose account details. Offer human transfer, callback, or alternate verification.",
          "allow_interrupt": true,
          "add_global_prompt": true,
          "extraction_enabled": false,
          "tool_uuids": [],
          "document_uuids": []
        }
      },
      {
        "id": "end-1",
        "type": "endCall",
        "position": { "x": 1180, "y": 220 },
        "data": {
          "name": "End Call",
          "prompt": "Close the conversation politely.",
          "allow_interrupt": false,
          "add_global_prompt": true,
          "tool_uuids": [],
          "document_uuids": []
        }
      }
    ],
    "edges": [
      { "id": "e-start-verify", "source": "start-1", "target": "agent-verify-1", "data": { "condition": "after greeting and collection" } },
      { "id": "e-verify-yes", "source": "agent-verify-1", "target": "agent-verified-1", "data": { "condition": "verification_result == verified" } },
      { "id": "e-verify-no", "source": "agent-verify-1", "target": "agent-fallback-1", "data": { "condition": "verification_result != verified" } },
      { "id": "e-verified-end", "source": "agent-verified-1", "target": "end-1", "data": { "condition": "after account discussion" } },
      { "id": "e-fallback-end", "source": "agent-fallback-1", "target": "end-1", "data": { "condition": "after fallback handling" } }
    ]
  }
}
```

## 3) Live test values

Use this in the mock verification backend:
- `full_name = Joe Black`
- `id_number = 123456`
- result = `verified`

Anything else should return `not verified`.
