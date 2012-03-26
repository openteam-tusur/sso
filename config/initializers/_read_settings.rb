Settings.define 'app.url',                            :env_var => 'APP_URL',                    :required => true
Settings.define 'mailer.sender_email',                :env_var => 'SENDER_EMAIL',               :required => true
Settings.define 'mailer.smtp.address',                :env_var => 'SMTP_ADDRESS',               :required => true
Settings.define 'mailer.smtp.port',                   :env_var => 'SMTP_PORT'
Settings.define 'mailer.smtp.domain',                 :env_var => 'SMTP_DOMAIN'
Settings.define 'mailer.smtp.user_name',              :env_var => 'SMTP_USER_NAME'
Settings.define 'mailer.smtp.password',               :env_var => 'SMTP_PASSWORD'
Settings.define 'mailer.smtp.authentication',         :env_var => 'SMTP_AUTHENTICATION'
Settings.define 'mailer.smtp.enable_starttls_auto',   :env_var => 'SMTP_ENABLE_STARTTLS_AUTO'

Settings.resolve!
