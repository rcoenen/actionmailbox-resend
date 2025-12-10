# Implementation Tasks

## 1. Core Implementation
- [ ] 1.1 Read current `build_rfc822_message` method
- [ ] 1.2 Add `normalize_mail_for_display` method to controller
- [ ] 1.3 Update `build_rfc822_message` to call normalization before returning
- [ ] 1.4 Handle normalization errors gracefully with fallback to original message

## 2. Version & Documentation
- [ ] 2.1 Update `lib/action_mailbox/resend/version.rb` to 1.0.3
- [ ] 2.2 Add entry to CHANGELOG.md for v1.0.3
- [ ] 2.3 Document the bug fix and MIME structure improvements

## 3. Testing & Validation
- [ ] 3.1 Review existing specs for compatibility
- [ ] 3.2 Run test suite: `bundle exec rspec`
- [ ] 3.3 Build gem: `gem build actionmailbox-resend.gemspec`
- [ ] 3.4 Test locally with demo/chatwoot integration
- [ ] 3.5 Verify `.eml` files from normalized emails open correctly

## 4. Release
- [ ] 4.1 Commit changes with descriptive message
- [ ] 4.2 Tag release: `git tag v1.0.3`
- [ ] 4.3 Push to GitHub: `git push origin main --tags`
- [ ] 4.4 Push to RubyGems: `gem push actionmailbox-resend-1.0.3.gem`
