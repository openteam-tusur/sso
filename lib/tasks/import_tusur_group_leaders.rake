# encoding: utf-8
require 'progress_bar'

desc 'Импорт старост групп в sso'
task :import_tusur_group_leaders => :environment do
  yml_path = ENV['YML_PATH'] || "#{File.dirname(File.expand_path(__FILE__))}/group_leaders.yml"
  list = YAML.load_file(yml_path)
  list['group_leader'].each do |faculty, groups|
    bar = ProgressBar.new(groups.count)
    puts faculty
    record = nil
    begin
      User.transaction do
        groups.each do |_, student|
          record = student
          next if student['uid']
          student['password'] ||= sprintf("%08d", SecureRandom.random_number(10**8))
          user = User.find_or_initialize_by_email(student['email'])
          user.first_name            = student['name']
          user.last_name             = student['surname']
          user.middle_name           = student['patronymic']
          user.password              = student['password']
          user.password_confirmation = user.password
          user.save!
          student['uid'] = user.id
          bar.increment!
        end
      end
    rescue => e
      puts
      puts
      user_name = "#{record['surname']} #{record['name']} <#{record['email']}>"
      divider = "-" * (user_name.length + 4)
      puts divider
      puts "| #{user_name} |"
      puts divider
      puts
      raise e
    end
  end

  File.open(yml_path, "w") do |file|
    file.write list.to_yaml
  end
end
