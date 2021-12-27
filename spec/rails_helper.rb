# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.infer_base_class_for_anonymous_controllers = false

  config.before(:each, type: :system) do 
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do 
    ENV['RUN_HEADLESSLY'] ? driven_by(:headless_selenium_chrome) : driven_by(:selenium_chrome)

    Capybara.server_host = IntegrationConfig::SERVER_HOST
    Capybara.server_port = IntegrationConfig::SERVER_PORT
    Capybara.app_host = IntegrationConfig::APP_HOST
  end
end
