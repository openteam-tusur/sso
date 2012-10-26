# encoding: utf-8
require 'progress_bar'

def yml_path
  @yml_path ||= File.expand_path('../../../config/users.yml', __FILE__)
end

def yaml
  @yaml ||= YAML.load_file(yml_path)
end

def write_yaml
  File.open(yml_path, "w"){ |f| f.write yaml.to_yaml }
end

def process(records, options={}, &block)
  current = nil
  bar = ProgressBar.new(records.count)
  begin
    User.transaction do
      records.each do |record|
        current = record
        block.call(record)
        bar.increment!
      end
    end
  rescue => e
    user = "#{current['surname']} #{current['name']} (гр. #{current['group']}) <#{current['email']}>"
    divider = "-" * (user.length + 4)
    puts "\n#{divider}\n| #{user} |\n#{divider}\n"
    raise e
  end
  write_yaml
end

desc 'Импорт пользователей ТУСУР в sso'
task :import_tusur_users => :environment do
  process yaml.values.flatten.reject{|u| u['uid']} do |record|
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
