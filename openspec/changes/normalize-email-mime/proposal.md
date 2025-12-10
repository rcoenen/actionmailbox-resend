# Change: Normalize email MIME structure for desktop client compatibility

## Why
Raw RFC822 messages built from Resend API JSON may not have a MIME structure that renders correctly when saved as `.eml` files and opened in desktop email clients like Apple Mail or Thunderbird. Currently, emails are stored in ActionMailbox's Active Storage without normalization, causing rendering issues when users extract and view them as `.eml` files.

This is a **bug fix** that ensures proper MIME structure compatibility with desktop email clients.

## What Changes
- Add email normalization logic to `InboundEmailsController#build_rfc822_message`
- Restructure MIME messages to use proper multipart hierarchy: `multipart/mixed` → `multipart/related` → `multipart/alternative` with text/html parts and attachments
- Normalize before submitting to ActionMailbox, ensuring emails in Active Storage have proper structure
- Ensure `.eml` files extracted from Active Storage open correctly in desktop email clients

This matches the normalization logic added to the Rails core PR (rails/rails#56328).

## Impact
- Affected specs: `ingress-webhook` capability (MODIFIED requirement for RFC822 construction)
- Affected code:
  - `app/controllers/action_mailbox/resend/inbound_emails_controller.rb` (add normalization method)
  - Tests may need updates to verify normalized structure
- Version: 1.0.2 → 1.0.3 (bug fix release)
