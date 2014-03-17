require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Sso
  class Application < Rails::Application
    config.time_zone = 'Asia/Novosibirsk'
    config.i18n.default_locale = :ru
    I18n.enforce_available_locales = false
  end
end
