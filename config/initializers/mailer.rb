ActionMailer::Base.default_url_options = { :host => Settings[:host] }
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = Settings['mailer.smtp']
