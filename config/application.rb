require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BugTrivia
  class Application < Rails::Application
    config.assets.precompile += [
      'application.js'
    ]
    config.assets.initialize_on_precompile = false    
  end
end
