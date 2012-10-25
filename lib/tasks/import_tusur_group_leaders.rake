# encoding: utf-8
require 'progress_bar'

desc 'Импорт старост групп в sso'
task :import_tusur_group_leaders => :environment do
  yml_path = ENV['YML_PATH'] || "#{File.dirname(File.expand_path(__FILE__))}/group_leaders.yml"
  list = YAML.load_file(yml_path)
  list['group_leader'].each do |faculty, students|
    bar = ProgressBar.new(students.count)
    puts faculty
    current = nil
    begin
      User.transaction do
        students.each do |student|
          current = student
          User.find_or_initialize_by_email(student['email']).tap do |user|
            user.first_name            = student['name']
            user.last_name             = student['surname']
            user.middle_name           = student['patronymic']
            user.password              = sprintf("%08d", SecureRandom.random_number(10**8))
            user.password_confirmation = user.password
            user.save!

            student['password']        = user.password
            student['uid']             = user.id
          end unless student['uid']
          bar.increment!
        end
      end
    rescue => e
      puts
      user_name = "#{current['surname']} #{current['name']} (гр. #{current['group']}) <#{current['email']}>"
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
