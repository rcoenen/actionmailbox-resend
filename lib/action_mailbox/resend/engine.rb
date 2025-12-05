# frozen_string_literal: true

module ActionMailbox
  module Resend
    class Engine < ::Rails::Engine
      isolate_namespace ActionMailbox::Resend

      # Load the engine's routes automatically
      initializer "actionmailbox-resend.load_routes" do |app|
        app.routes.append do
          # Allow mounting at a custom path if not already mounted
        end
      end
    end
  end
end
