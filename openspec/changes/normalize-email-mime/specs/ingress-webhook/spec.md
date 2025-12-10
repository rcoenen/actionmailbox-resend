## MODIFIED Requirements
### Requirement: RFC822 message construction
The ingress SHALL fetch email data from Resend API and convert JSON to proper RFC822 MIME messages with normalized multipart structure for desktop email client compatibility. The normalization ensures emails stored in ActionMailbox's Active Storage can be extracted as `.eml` files that open correctly in Apple Mail, Thunderbird, and other desktop clients.

#### Scenario: Multipart email with attachments
- **WHEN** Resend provides email with text, HTML, and attachments
- **THEN** the RFC822 message uses normalized MIME structure: `multipart/mixed` → `multipart/related` → `multipart/alternative` with text/html parts separated, inline attachments with content IDs preserved, and regular attachments at top level

#### Scenario: Normalized email opens in desktop clients
- **WHEN** an email is processed and stored in ActionMailbox's Active Storage
- **THEN** extracting and saving the email as a `.eml` file produces a file that opens correctly in Apple Mail and Thunderbird with proper rendering of text, HTML, inline images, and attachments

#### Scenario: Normalization error handling
- **WHEN** email normalization fails due to malformed content
- **THEN** the system logs a warning and falls back to the original RFC822 message without normalization, ensuring email processing continues
