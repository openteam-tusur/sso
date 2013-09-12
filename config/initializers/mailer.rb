settings = URI.parse(Settings['app.url'])

ActionMailer::Base.default_url_options = { :host => settings.host, :scheme => settings.scheme, :port => settings.port }
ActionMailer::Base.delivery_method = Settings['mailer.delivery_method'].to_sym
ActionMailer::Base.postmark_settings = { :api_key => Settings['mailer.postmark.api_key'] } if Settings['mailer.delivery_method'] == 'postmark'
ActionMailer::Base.smtp_settings = Settings['mailer.smtp'] if Settings['mailer.delivery_method'] == 'smtp'
