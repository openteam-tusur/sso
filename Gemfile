source :rubygems

group :assets do
  gem 'therubyracer'                                                            unless RUBY_PLATFORM =~ /freebsd/
  gem 'uglifier'
end

group :default do
  gem 'sass-rails'
  gem 'compass-rails'
  gem 'configliere'
  gem 'default_value_for'
  gem 'devise'
  gem 'devise-russian'
  gem 'formtastic',                                 :require => false
  gem 'has_searcher'
  gem 'inherited_resources'
  gem 'jquery-rails'
  gem 'omniauth'
  gem 'openteam-commons'
  gem 'rails',                                      :require => false
  gem 'russian'
  gem 'sunspot_rails'
end

group :development do
  gem 'annotate',             '~> 2.4.1.beta1'
  gem 'sunspot_solr'
end

group :production do
  gem 'pg',                                         :require => false
end

group :test do
  gem 'sqlite3',                                    :require => false
end
