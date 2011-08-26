require 'faker'

namespace :db do
  desc "Fill db avec amis sample"
  #rake db:populate
  task :make_relations => :environment do
    
    100.times do
      src = User.all[rand(User.all.length)]
      tar = User.all[rand(User.all.length)]
      src.follow!(tar) unless src == tar
    end
    
  end
end
