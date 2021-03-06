require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'action_mailer/railtie'
require 'active_job/railtie'
require 'action_cable/engine'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'rails/test_unit/railtie'
# require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Templatus
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.time_zone = ENV.fetch('TIME_ZONE', 'Berlin')
    config.x.app_host = ENV.fetch('APP_HOST', 'templatus.test')
    config.x.force_ssl = ENV.fetch('FORCE_SSL', 'true') == 'true'

    config.x.git.commit_sha =
      (ENV.fetch('COMMIT_SHA') { `git rev-parse HEAD`.chomp })
    config.x.git.commit_time =
      ENV.fetch('COMMIT_TIME') { `git show -s --format=%cI`.chomp }

    config.x.honeybadger.api_key = ENV['HONEYBADGER_API_KEY']
  end
end

# Makes sure the TailwindCSS JIT doesn't run forever
Webpacker::Compiler.env['TAILWIND_MODE'] = 'build'
