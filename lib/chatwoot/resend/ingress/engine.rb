# frozen_string_literal: true

module Chatwoot
  module Resend
    module Ingress
      class Engine < ::Rails::Engine
        isolate_namespace Chatwoot::Resend::Ingress

        # Load the engine's routes automatically
        initializer "chatwoot-resend-ingress.load_routes" do |app|
          app.routes.append do
            # Allow mounting at a custom path if not already mounted
          end
        end
      end
    end
  end
end
