require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ShopifySyncMorningbird
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    ShopifyAPI::Context.setup(
      api_key: 'a7dba99a1a0a96f6939e42ec27ed917a',
      api_secret_key: '85f31c1d99db530f7746b9a4105773a5',
      host: 'https://5ee9-2a09-bac5-d46c-e6-00-17-182.ngrok-free.app',
      scope: 'read_orders,read_products',
      is_embedded: true,
      api_version: '2023-10',
      is_private: false
    )
  end
end
