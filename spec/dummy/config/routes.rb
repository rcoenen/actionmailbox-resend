# frozen_string_literal: true

Rails.application.routes.draw do
  mount Chatwoot::Resend::Ingress::Engine, at: "/rails/action_mailbox/resend"
end
