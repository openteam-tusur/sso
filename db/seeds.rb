User.new.tap do | user |
  user.email = 'admin@demo.org'
  user.first_name = 'Administrator'
  user.admin = true
  user.password = SecureRandom.hex
  user.password_confirmation = user.password
  user.save!
  puts "Admin account: login: #{user.email}, password: #{user.password}"
end
