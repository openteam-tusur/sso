source 'http://rubygems.org'

group :assets do
  gem 'therubyracer'                                unless RUBY_PLATFORM =~ /freebsd/
  gem 'uglifier'
end

group :default do
  gem 'attribute_normalizer'
  gem 'compass-rails'
  gem 'configliere'
  gem 'default_value_for'
  gem 'devise'
  gem 'devise-russian'
  gem 'formtastic',         '~> 2.1.0'
  gem 'inherited_resources'
  gem 'jquery-rails'
  gem 'validates_email_format_of'
  gem 'omniauth'
  gem 'openteam-commons'
  gem 'progress_bar',                               :require => false
  gem 'rails',              '~> 3.2.12',            :require => false
  gem 'russian'
  gem 'sass-rails'
  gem 'sunspot_rails',      '>= 2.0.0.pre.120417'
end

group :development do
  gem 'annotate'
  gem 'brakeman'
  gem 'debugger'
  gem 'sunspot_solr',       '>= 2.0.0.pre.120417',  :require => false
  gem 'rvm-capistrano'
end

group :production do
  gem 'pg',                                         :require => false
end

group :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'sqlite3',                                    :require => false
end
