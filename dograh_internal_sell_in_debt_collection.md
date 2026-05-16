# Selling Dograh Internally in a Debt Collection Company

## The core message
This is not a chatbot project. It is a controlled voice-operations layer that reduces call handling cost, improves contact rates, and creates auditable conversations across countries without locking us into a vendor.

## The executive pitch
- We can standardize voice operations across DK, DE, SE, NO, and FI.
- We can keep data on our own infrastructure.
- We can choose carriers per country instead of forcing one vendor everywhere.
- We can use Azure OpenAI under our existing tenant and controls.
- We can prove what the system said, heard, and recorded.

## The business problems it solves
- too many manual reminder calls
- inconsistent call quality across markets
- limited agent capacity for first contact and callbacks
- poor visibility into outcomes and call disposition
- slow scaling when volumes spike

## Best first use cases
Start with low-risk, high-volume, high-repeatability tasks:
- payment reminders
- promise-to-pay capture
- callback scheduling
- payment plan routing
- account status FAQs
- human handoff when the customer wants a person

Avoid starting with anything that is legally or reputationally sensitive.

## What to say to leadership
Use this framing:
1. Operational efficiency — fewer manual calls, lower handling cost.
2. Control — hosted in our environment, not a black-box SaaS.
3. Compliance — auditable logs, retained recordings, configurable scripts, country-specific routing.
4. Scalability — one platform, multiple countries, multiple providers.
5. Faster experimentation — we can pilot in one market before rolling out.

## What to say to risk and compliance
- We are not deploying a free-form AI agent.
- The scripts are controlled, reviewed, and versioned.
- Call recordings and transcripts are retained according to policy.
- We can enforce human handoff for edge cases.
- The system can be restricted to specific hours, languages, and account segments.
- Provider and model usage can be locked to approved vendors.

## What to say to IT security
- Source is open and inspectable.
- Containers can be pinned to immutable digests.
- Secrets are externalized.
- Network exposure can be tightly controlled.
- Health checks, logs, and backups are documented.
- We can run a local evaluation before production.

## What to say to operations
- The workflow can be the same across countries.
- The phone provider can vary by country behind the scenes.
- Agents can review transcripts, dispositions, and recordings in one place.
- Failures are visible and recoverable.

## Pilot design
### Scope
- 1 country
- 1 telephony provider
- 1 use case
- 1–2 workflows
- limited call volume

### Success metrics
- answer rate
- completion rate
- promise-to-pay capture rate
- transfer-to-human rate
- average handling time
- complaint rate
- opt-out rate
- cost per resolved account

### Exit criteria
- no compliance red flags
- stable calling and logging
- acceptable customer experience
- measurable improvement over manual calling

## Objections you will hear
### "AI will hurt our brand"
Answer: We start with tightly controlled scripts, compliance-approved wording, and human fallback.

### "This will be risky"
Answer: That is why we pilot a narrow use case, in one market, with audit trails and call recordings.

### "We already have a dialer"
Answer: Good. This complements or modernizes the voice layer and can sit beside existing operations.

### "One vendor is simpler"
Answer: Simpler in the short term, riskier long term. A portable stack reduces lock-in and improves resilience.

## The rollout story
- Phase 1: internal proof of concept
- Phase 2: compliance review and security sign-off
- Phase 3: pilot in one country
- Phase 4: country-by-country expansion
- Phase 5: formal operating model and reporting

## The non-negotiables
- compliant call scripts
- clear consent and recording policy
- human escalation
- retention and deletion policy
- auditability
- vendor and model approval

## The strongest line to use
"We are not buying a chatbot. We are building a controlled, auditable calling platform that our team can own, verify, and scale across the Nordics and DACH."
