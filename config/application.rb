require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Btcneco
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Custom error pages
    config.exceptions_app = self.routes

    config.after_initialize do
      if Admin.last && Admin.last.setting
        setting = Admin.last.setting
        config.action_mailer.smtp_settings = {
          :user_name => setting.mail_user_name,
          :password  => setting.mail_password,
          :domain    => setting.mail_domain,
          :address   => setting.mail_address,
          :port      => setting.mail_port,
          :authentication => setting.mail_authentication,
          :enable_starttls_auto => setting.mail_enable_starttls_auto
        }
      end
    end
  end
end
