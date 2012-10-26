# encoding: utf-8
require 'progress_bar'

require File.expand_path '../import_tusur_users', __FILE__

def filter(record)
  ENV['EMAIL'] ? record['email'] == ENV['EMAIL'] : !record['uid']
end

def process_user(record)
  User.find_or_initialize_by_email(record['email']).tap do |user|
    user.first_name  ||= record['name']
    user.last_name   ||= record['surname']
    user.middle_name ||= record['patronymic'].presence

    if user.new_record?
      record['password']         ||= sprintf("%08d", SecureRandom.random_number(10**8))
      user.password                = record['password']
      user.password_confirmation   = record['password']
    end

    user.save!

    record['name']       = user.first_name
    record['surname']    = user.last_name
    record['patronymic'] = user.middle_name.presence
    record['uid']        = user.id
  end
end

alias :process_dean :process_user
alias :process_student :process_user

desc 'Импорт пользователей ТУСУР в sso'
task :import_tusur_users => :environment do
  process
end
