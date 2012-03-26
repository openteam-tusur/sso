settings = URI.parse(Settings['app.url'])

ActionMailer::Base.default_url_options = { :host => settings.host, :scheme => settings.scheme, :port => settings.port }
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = Settings['mailer.smtp']
