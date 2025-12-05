# ActionMailbox Resend

A Rails Engine providing [Resend](https://resend.com) email ingress support for ActionMailbox.

This gem receives webhooks from Resend's inbound email API, verifies signatures via Svix, reconstructs RFC822 MIME messages (including attachments and inline images), and delivers them to ActionMailbox for processing.

## Features

- Webhook-based email ingestion via Resend's email receiving API
- Cryptographic signature verification using Svix
- Full attachment support (regular + inline images)
- Data URI to CID conversion for inline images
- Email threading support (In-Reply-To, References headers)
- SSRF protection with URL allow-listing
- Idempotency via webhook deduplication
- Request size limits and HTTP timeouts

## Installation

Add this line to your application's Gemfile:

```ruby
gem "actionmailbox-resend"
```

And then execute:

```bash
bundle install
```

## Configuration

### Environment Variables

Set the following environment variables:

```bash
RESEND_API_KEY=re_xxx           # Your Resend API key
RESEND_WEBHOOK_SECRET=whsec_xxx  # Your Resend webhook signing secret
```

### Mount the Engine

In your `config/routes.rb`:

```ruby
Rails.application.routes.draw do
  mount ActionMailbox::Resend::Engine, at: "/rails/action_mailbox/resend"
end
```

This creates the webhook endpoint at:
```
POST /rails/action_mailbox/resend/inbound_emails
```

## Resend Setup

1. **Enable Inbound Emails** in your Resend dashboard
2. **Configure Email Forwarding** to forward emails to your domain
3. **Add Webhook Endpoint**: `https://your-domain.com/rails/action_mailbox/resend/inbound_emails`
4. **Copy Webhook Signing Secret** to your `RESEND_WEBHOOK_SECRET` environment variable

## Usage with Chatwoot

After installing the gem, Chatwoot will automatically process inbound emails from Resend through ActionMailbox.

For Chatwoot-specific setup:

1. Add the gem to Chatwoot's Gemfile
2. Mount the engine in routes.rb (as shown above)
3. Configure the environment variables
4. Set up email forwarding in Resend to your support email address

## How It Works

1. **Webhook Reception**: Resend sends a webhook when an email is received
2. **Signature Verification**: The gem verifies the Svix signature to ensure authenticity
3. **Email Fetch**: Full email content is fetched from Resend's API (webhooks only contain email IDs)
4. **Attachment Download**: Attachments are fetched via a two-step process (metadata → download URL → content)
5. **RFC822 Construction**: The JSON email data is converted to a proper RFC822 MIME message
6. **ActionMailbox Delivery**: The message is submitted to ActionMailbox for processing

### RFC822 Reconstruction

Unlike other email providers that send emails in RFC822 format, Resend provides structured JSON. This gem handles the complex conversion including:

- Proper multipart MIME boundaries
- Content-Type headers for each part
- Content-Transfer-Encoding for attachments
- Content-ID for inline images
- Data URI to CID reference conversion

## Security

- **Svix Signature Verification**: All webhooks are cryptographically verified
- **SSRF Protection**: Attachment downloads are restricted to `*.resend.com` and `*.resend.app` domains
- **Size Limits**: 10MB max request size, 25MB max attachment size
- **Timeout Protection**: 5s connection timeout, 10s read timeout
- **Redirect Blocking**: Prevents redirect-based SSRF attacks
- **Idempotency**: 24-hour deduplication via `svix-id` header

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rspec` to run the tests.

```bash
git clone https://github.com/rcoenen/actionmailbox-resend.git
cd actionmailbox-resend
bin/setup
bundle exec rspec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rcoenen/actionmailbox-resend.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Related Links

- [Resend Inbound Email Docs](https://resend.com/docs/api-reference/emails/receive-email)
- [Resend Webhooks](https://resend.com/docs/webhooks)
- [Svix Webhook Verification](https://docs.svix.com/receiving/verifying-payloads/how)
- [Rails ActionMailbox](https://guides.rubyonrails.org/action_mailbox_basics.html)
- [Chatwoot](https://chatwoot.com)
