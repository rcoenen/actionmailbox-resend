# Changelog

All notable changes to this project will be documented in this file.

## 1.0.2 - 2025-12-08
- Fix OpenSSL 3.x CRL verification for webhook signature validation ([PR #1](https://github.com/rcoenen/actionmailbox-resend/pull/1), thanks [@lylo](https://github.com/lylo)).
- Pin development runtime to Ruby 3.4.7 / Bundler 2.7.x; gem requires Ruby >= 3.1.
- Return numeric HTTP 422 when `email_id` is missing to avoid Rack deprecation warnings; specs updated.
- Add OpenSpec/agent assets to support spec-driven workflow (internal tooling).

## 1.0.1 - 2025-12-05
- Add Bundler autoload entry point so the gem loads reliably when required.

## 1.0.0 - 2025-12-05
- Initial release of Resend inbound webhook ingestion for Rails ActionMailbox, including Svix signature verification, MIME reconstruction with attachment and inline image handling, SSRF protections, and inline CID mapping.
