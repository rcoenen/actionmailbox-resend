# Change: Pin Ruby runtime and explicit 422 response

## Why
- Avoid Rack deprecation tied to symbol-based 422 response codes in the webhook controller.
- Ensure contributors use the intended Ruby version via rbenv for consistent Bundler/gem resolution.

## What Changes
- Pin the project Ruby via `.ruby-version` to 3.4.7 (Ruby >= 3.1 required by the gemspec; Bundler 2.7.x).
- Return HTTP 422 using a numeric status for missing `email_id` in Resend webhook payloads.
- Reinstall gems and run the test suite under the pinned Ruby.

## Impact
- Affected specs: ingress-webhook
- Affected code: app/controllers/action_mailbox/resend/inbound_emails_controller.rb, spec/controllers/action_mailbox/resend/inbound_emails_controller_spec.rb, .ruby-version
