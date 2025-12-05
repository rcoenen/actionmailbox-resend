# frozen_string_literal: true

Rails.application.routes.draw do
  mount ActionMailbox::Resend::Engine, at: "/rails/action_mailbox/resend"
end
