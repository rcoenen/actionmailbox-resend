# Project Context

## Purpose
Provide a Rails Engine/gem (`actionmailbox-resend`) that adds Resend inbound email webhook support to ActionMailbox by verifying Svix signatures, fetching full email payloads (including attachments), rebuilding RFC822 MIME messages, and handing them off to ActionMailbox for processing.
- Published gem: https://rubygems.org/gems/actionmailbox-resend

## Tech Stack
- Ruby 3.1+ with Rails 7+ (ActionMailbox engine); Bundler 2.7.x
- Net::HTTP for Resend API calls and attachment downloads
- Mail gem for RFC822/MIME construction
- RSpec + RSpec Rails + WebMock, SQLite (in-memory) for the dummy test app

## Project Conventions

### Code Style
- Ruby-first conventions with `# frozen_string_literal: true`, guard clauses, and explicit error logging
- RSpec `expect` syntax, shared helpers in `spec/support`, WebMock for all external HTTP
- RuboCop not enforced repo-wide; inline disables exist for unavoidable complexity
- Environment configuration via `ENV.fetch` for required secrets/keys

### Architecture Patterns
- Rails engine isolated under `ActionMailbox::Resend`; mount at `/rails/action_mailbox/resend/inbound_emails`
- Single controller (`InboundEmailsController`) handles webhooks, Svix signature verification, Resend fetches, RFC822 assembly, and delivery to `ActionMailbox::InboundEmail`
- Rails.cache used for 24h idempotency keyed by `svix-id`
- MIME building uses Mail gem parts (`text_part`, `html_part`, inline/regular attachments) with data-URI → `cid:` conversion for inline images
- HTTP interactions done with Net::HTTP using short timeouts and explicit host allowlisting for attachments

### Testing Strategy
- `bundle exec rspec`; tests run against a dummy Rails app with in-memory SQLite and ActionMailbox/ActiveStorage tables
- WebMock stubs all Resend and Svix interactions; helpers in `spec/support/resend_spec_helpers.rb`
- Controller specs assert RFC822 content, threading headers, inline image handling, and idempotency/caching behavior
- Cache cleared after each example; transactional fixtures disabled

### Git Workflow
- Default branch `main`; use PRs targeting `main`
- Follow OpenSpec guidance for new capabilities or behavioral changes; small bug fixes can go direct without proposals

## Domain Context
- Resend sends JSON webhooks (`email.received`); we fetch the full email and attachments via Resend API before passing to ActionMailbox
- Inline images arrive as data URIs and must be mapped to `cid:` references matching attachment Content-IDs
- BCC headers are intentionally omitted in final RFC822 per RFC 5322; threading headers (Message-ID, In-Reply-To, References) are preserved when present

## Important Constraints
- Requires `RESEND_API_KEY` and `RESEND_WEBHOOK_SECRET` environment variables
- Runtime requires Ruby >= 3.1 (gemspec) and Bundler 2.7.x (lockfile)
- Svix signature verification mandatory; rejects missing/invalid signatures or stale timestamps
- Request size capped at 10MB; attachments capped at 25MB with HEAD size check before download
- Attachment downloads must be HTTPS and match `*.resend.com`/`*.resend.app`; redirects are blocked to prevent SSRF
- Network timeouts: 5s connect, 10s read; idempotency via Rails.cache for 24h keyed by `svix-id`
- Only processes `email.received` events; missing `email_id` returns 422

## External Dependencies
- Resend Inbound Email API (`/emails/receiving/:id`) and attachment endpoints
- Svix webhook verification (`svix` gem)
- Rails ActionMailbox and ActiveStorage stack for inbound processing and attachment handling
- Mail gem for RFC822 construction
