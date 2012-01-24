ActionMailer::Base.default_url_options = { :host => Settings[:mailer][:app_host] }
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address => Settings[:mailer][:smtp_address],
  :port    => Settings[:mailer][:smtp_port]
}
