# frozen_string_literal: true

require_relative "boot"

require "rails"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "active_record/railtie"

Bundler.require(*Rails.groups)
require "chatwoot/resend/ingress"

module Dummy
  class Application < Rails::Application
    config.load_defaults Rails::VERSION::STRING.to_f

    # Settings in config/environments/* take precedence over those specified here.
    config.eager_load = false

    # Use a simple cache store for testing
    config.cache_store = :memory_store

    # Set root path
    config.root = File.expand_path("..", __dir__)
  end
end
