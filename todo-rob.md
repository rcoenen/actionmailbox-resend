# TODO for Resend ActionMailbox ingress (handover notes)

- [ ] Implement Resend ingress in Rails core
  - [ ] Add controller/ingress under `actionmailbox/lib/action_mailbox/ingress/resend/`
  - [ ] Avoid new dependencies; implement minimal signature verification inline (Rails is reluctant to add svix)
  - [ ] Mirror existing ingress patterns (request size limits, host allowlists, attachment handling, idempotency if feasible)

- [ ] Tests
  - [ ] Add ActionMailbox tests in `actionmailbox/test/` similar to other provider ingresses
  - [ ] Cover valid webhook, missing email_id (422), invalid signature, attachment handling, threading headers, inline images if included

- [ ] Docs
  - [ ] Add a brief section to `guides/source/action_mailbox_basics.md` describing Resend setup (endpoint path, required env vars, signature verification)
  - [ ] Keep tone/format consistent with other ingress sections

- [ ] Compliance with Rails contributing guidelines
  - [ ] Follow Rails code style and existing ingress structure
  - [ ] Keep changes minimal and self-contained
  - [ ] Run relevant ActionMailbox test suite locally
  - [ ] Reference: https://guides.rubyonrails.org/contributing_to_ruby_on_rails.html

- [ ] PR prep
  - [ ] Confirm branch `add-actionmailbox-resend-ingress` is up to date with `rails/rails` main
  - [ ] Ensure commits are tidy; include tests/docs in same PR
  - [ ] Summarize behavior/safety (signature verification, SSRF protections) in PR description

## Briefing (Resend + Rails)
- Goal: upstream Resend as a first-class Action Mailbox ingress (like Postmark/Mailgun/SendGrid) with no dependency on the external gem.
- Code placement: `actionmailbox/lib/action_mailbox/ingress/resend/`; tests in `actionmailbox/test/`; docs update in `guides/source/action_mailbox_basics.md`.
- Scope: minimal webhook-handling logic; no major rewrite, no prior permission needed.
- Outcome: Rails ships Resend ingress out-of-the-box; maintenance shifts to Rails core.
