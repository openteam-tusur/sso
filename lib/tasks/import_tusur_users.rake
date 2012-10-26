# encoding: utf-8
require 'progress_bar'

require File.expand_path '../import_tusur_users', __FILE__

desc 'Импорт пользователей ТУСУР в sso'
task :import_tusur_users => :environment do
  process yaml.values.flatten.reject{|r| r['uid']} do |record|
    User.find_or_initialize_by_email(record['email']).tap do |user|
      user.first_name            = record['name']
      user.last_name             = record['surname']
      user.middle_name           = record['patronymic']
      user.password              = sprintf("%08d", SecureRandom.random_number(10**8))
      user.password_confirmation = user.password
      user.save!

      record['password']        = user.password
      record['uid']             = user.id
    end
  end
end
