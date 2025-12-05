# frozen_string_literal: true

require "spec_helper"

ENV["RAILS_ENV"] = "test"

# Load the dummy Rails application
require_relative "dummy/config/environment"

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

require "rspec/rails"
require "webmock/rspec"

# Set up in-memory database with ActionMailbox table
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
ActiveRecord::Schema.define do
  create_table :action_mailbox_inbound_emails do |t|
    t.integer :status, default: 0, null: false
    t.string :message_id, null: false
    t.string :message_checksum, null: false
    t.timestamps
  end
  add_index :action_mailbox_inbound_emails, [:message_id, :message_checksum], name: "index_action_mailbox_inbound_emails_uniqueness", unique: true

  create_table :active_storage_blobs do |t|
    t.string :key, null: false
    t.string :filename, null: false
    t.string :content_type
    t.text :metadata
    t.string :service_name, null: false
    t.bigint :byte_size, null: false
    t.string :checksum
    t.timestamps
  end
  add_index :active_storage_blobs, [:key], unique: true

  create_table :active_storage_attachments do |t|
    t.string :name, null: false
    t.string :record_type, null: false
    t.bigint :record_id, null: false
    t.bigint :blob_id, null: false
    t.timestamps
  end
  add_index :active_storage_attachments, [:blob_id]
  add_index :active_storage_attachments, [:record_type, :record_id, :name, :blob_id], name: "index_active_storage_attachments_uniqueness", unique: true
end

# Load support files
Dir[File.join(__dir__, "support", "**", "*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  # Include WebMock
  config.before(:each) do
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  config.after(:each) do
    WebMock.reset!
    Rails.cache.clear  # Clear cache to reset idempotency checks
  end
end
