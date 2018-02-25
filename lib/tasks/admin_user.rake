namespace :admin_user do
  desc "create first admin user"
  task :install => :environment do
    User.create(name: "it", password: "123456", password_confirmation: "123456")
  end
end