# encoding: utf-8
require 'progress_bar'

desc 'Импорт старост групп в sso'
task :import_tusur_group_leaders => :environment do
  yml_path = ENV['YML_PATH'] || "#{File.dirname(File.expand_path(__FILE__))}/group_leaders.yml"
  list = YAML.load_file(yml_path)
  list['group_leader'].each do |faculty, groups|
    bar = ProgressBar.new(groups.count)
    puts faculty
    groups.each do |_, student|
      User.find_or_initialize_by_email(student['email']).tap do |user|
        user.first_name = student['name']
        user.last_name = student['surname']
        user.middle_name = student['patronymic']
        student['password'] ||= sprintf("%08d", SecureRandom.random_number(10**8))
        user.password =  student['password']
        user.password_confirmation = user.password
        user.save!
        student['uid'] = user.id
        bar.increment!
      end
    end
  end

  File.open(yml_path, "w") do |file|
    file.write list.to_yaml
  end
end
