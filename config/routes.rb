# frozen_string_literal: true

Chatwoot::Resend::Ingress::Engine.routes.draw do
  post "/inbound_emails" => "inbound_emails#create", as: :inbound_emails
end
