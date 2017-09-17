require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WorkflowBackendProject
  class Application < Rails::Application

  	config.load_defaults 5.1
  	config.time_zone = 'Brasilia'

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.generators do |g|
      g.test_framework :rspec,
                       #fixtures: false,
                       view_specs: false,
                       helper_specs: true,
                       routing_specs: true,
                       request_specs: false

    end

  end
end
