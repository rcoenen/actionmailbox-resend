# frozen_string_literal: true

require_relative "ingress/version"
require_relative "ingress/engine"

module Chatwoot
  module Resend
    module Ingress
      class Error < StandardError; end
    end
  end
end
