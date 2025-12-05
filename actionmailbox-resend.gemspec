# frozen_string_literal: true

require_relative "lib/action_mailbox/resend/version"

Gem::Specification.new do |spec|
  spec.name = "actionmailbox-resend"
  spec.version = ActionMailbox::Resend::VERSION
  spec.authors = ["rcoenen"]
  spec.email = ["rcoenen@users.noreply.github.com"]

  spec.summary = "Resend email ingress for ActionMailbox"
  spec.description = "A Rails Engine providing Resend email ingress support for ActionMailbox. " \
                     "Receives webhooks from Resend, verifies signatures via Svix, " \
                     "reconstructs RFC822 MIME messages, and delivers to ActionMailbox."
  spec.homepage = "https://github.com/rcoenen/actionmailbox-resend"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/rcoenen/actionmailbox-resend"
  spec.metadata["changelog_uri"] = "https://github.com/rcoenen/actionmailbox-resend/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.chdir(__dir__) do
    Dir["{app,config,lib}/**/*", "LICENSE.txt", "README.md"]
  end
  spec.require_paths = ["lib"]

  # Runtime dependencies
  spec.add_dependency "rails", ">= 7.0"
  spec.add_dependency "svix", "~> 1.0"

  # Development dependencies
  spec.add_development_dependency "rspec-rails", "~> 6.0"
  spec.add_development_dependency "webmock", "~> 3.18"
end
