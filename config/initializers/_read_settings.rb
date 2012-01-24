Settings.read(Rails.root.join('config', 'settings.yml'))

Settings.defaults Settings.extract!(Rails.env)[Rails.env] || {}
Settings.extract!(:test, :development, :production)

Settings.define 'hoptoad.api_key',            :env_var => 'HOPTOAD_API_KEY'
Settings.define 'hoptoad.host',               :env_var => 'HOPTOAD_HOST'

Settings.define 'mailer.app_host',            :env_var => 'MAILER_APP_HOST'
Settings.define 'mailer.smtp_address',        :env_var => 'MAILER_SMTP_ADDRESS'
Settings.define 'mailer.smtp_port',           :env_var => 'MAILER_SMTP_PORT'

Settings.resolve!
