require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module Sso
  class Application < Rails::Application
    config.time_zone = 'Krasnoyarsk'
    config.i18n.default_locale = :ru
    I18n.enforce_available_locales = false
  end
end
