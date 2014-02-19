source 'https://rubygems.org'

group :assets do
  gem 'bootstrap-sass', '~> 3.1.1'
  gem 'compass-rails'
  gem 'jquery-rails', '~> 2.1.4'
  gem 'sass-rails'
  gem 'turbo-sprockets-rails3'
  gem 'uglifier'
end

group :default do
  gem 'attribute_normalizer'
  gem 'configliere'
  gem 'default_value_for'
  gem 'delayed_job_active_record'
  gem 'devise'
  gem 'devise-async'
  gem 'devise-russian'
  gem 'inherited_resources'
  gem 'omniauth'
  gem 'openteam-commons'
  gem 'postmark-rails', '~> 0.5.2'
  gem 'progress_bar', :require => false
  gem 'rails', '~> 3.2.15'
  gem 'russian'
  gem 'simple_form'
  gem 'tusur_header', :git => 'git://github.com/openteam-tusur/tusur_header'
  gem 'validates_email_format_of'
end

group :development do
  gem 'annotate', :require => false
  gem 'brakeman', :require => false
  gem 'capistrano-db-tasks', :git => 'git://github.com/sgruhier/capistrano-db-tasks', :ref => '396cbbf', :require => false
  gem 'capistrano-unicorn', '~> 0.1.7', :require => false
  gem 'openteam-capistrano', :require => false
end

group :production do
  gem 'daemons'
  gem 'unicorn', '4.7.0'
  gem 'pg', :require => false
end

group :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'sqlite3', :require => false
end
