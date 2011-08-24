require 'faker'

namespace :db do
  desc "Fill db avec donne sample"
  #rake db:populate
  task :populate => :environment do
    Rake::Task["db:reset"].invoke #clears db
    admin = User.create!(:name => "spotco",
                 :email => "mootothemax@gmail.com",
                 :password => "dododo",
                 :password_confirmation => "dododo")
    admin.toggle!(:admin)
                 
    99.times do |n|
      name = Faker::Name.name
      email = "lolol#{n}@test.com"
      password = "dododorake"
      User.create!( :name => name,
                    :email => email,
                    :password => password,
                    :password_confirmation => password )
    end
  end
end
