require 'faker'

namespace :db do
  desc "Fill db avec quelques posts aleatoire"
  #rake db:make_posts
  task :make_posts => :environment do
    100.times do
      user = User.all[rand(User.all.length)]
      
      generatedcontent = ""
      
      (rand(50)+20).times do
        generatedcontent += (rand(29)+63).chr
        generatedcontent += " " if rand(5) == 0
      end
      user.microposts.create( :content => generatedcontent )
    end
    
  end
end
