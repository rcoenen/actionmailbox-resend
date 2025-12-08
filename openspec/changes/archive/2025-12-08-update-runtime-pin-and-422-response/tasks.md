## 1. Runtime and Status Alignment
- [x] 1.1 Set `.ruby-version` to 3.4.7 (Ruby >= 3.1 requirement) using rbenv local
- [x] 1.2 Install Bundler 2.7.2 and reinstall gems under the pinned Ruby
- [x] 1.3 Switch missing `email_id` response to numeric HTTP 422 in the Resend webhook controller
- [x] 1.4 Update controller spec to assert numeric 422 and rerun `bundle exec rspec`
