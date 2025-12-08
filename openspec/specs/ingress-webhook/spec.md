# ingress-webhook Specification

## Purpose
TBD - created by archiving change update-runtime-pin-and-422-response. Update Purpose after archive.
## Requirements
### Requirement: Ruby runtime pinning
The project SHALL pin the development/test Ruby version via rbenv to 3.4.7 (compatible with Ruby >= 3.1 required by the gemspec) to ensure consistent Bundler and gem resolution.

#### Scenario: Local Ruby version is pinned
- **WHEN** a developer runs `ruby -v` inside the repository with rbenv active
- **THEN** the reported Ruby version is 3.4.7

### Requirement: Missing email_id returns 422
The Resend webhook endpoint SHALL return HTTP status 422 when the incoming payload lacks `data.email_id` and MUST NOT enqueue or create an inbound email record.

#### Scenario: email_id missing
- **WHEN** the webhook request omits `data.email_id`
- **THEN** the response status is 422 and no ActionMailbox inbound email is created

