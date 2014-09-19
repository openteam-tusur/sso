require 'progress_bar'

task :export_users => :environment do
  users = User.order('current_sign_in_at desc')
  pb = ProgressBar.new(users.count)
  valid_users_arr = []
  invalid_users_arr = []

  users.each do |user|
    if valid_email?(user.email)
      valid_users_arr << user_hash(user)
    else
      invalid_users_arr << user_hash(user)
    end
    pb.increment!
  end

  write_file('valid', valid_users_arr) if valid_users_arr.any?
  write_file('invalid', invalid_users_arr) if invalid_users_arr.any?
end

def valid_email?(email)
  begin
    return false if ValidatesEmailFormatOf::validate_email_format(email, :check_mx => true)
  rescue
    puts email
    return false
  end
  true
end

def user_hash(user)
  {:old_uid => user.id, :name => user.first_name, :patronymic => user.middle_name, :surname => user.last_name, :email => user.email, :encrypted_password => user.encrypted_password, :current_sign_in_at => user.current_sign_in_at}
end

def write_file(name, arr)
  File.open("config/#{name}_users.json", 'w') do |file|
    file.write(arr.to_json)
  end
end
