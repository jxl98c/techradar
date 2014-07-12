fail "Users exist" if User.count > 0

admin = User.create!(
  name:                  ENV['ADMIN_NAME'],
  email:                 ENV['ADMIN_EMAIL'],
  password:              ENV['ADMIN_PASSWORD'],
  password_confirmation: ENV['ADMIN_PASSWORD'],
  admin: true
)
admin.confirm!
puts "Admin Created: #{admin.email}"

thoughtworks = User.create!(
  name:                  "ThoughtWorks",
  email:                 User::THOUGHTWORKS_EMAIL,
  password:              ENV['ADMIN_PASSWORD'],
  password_confirmation: ENV['ADMIN_PASSWORD']
)
thoughtworks.confirm!
puts "ThoughtWorks Created: #{thoughtworks.email}"
