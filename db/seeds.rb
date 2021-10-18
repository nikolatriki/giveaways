# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create(
  name: 'nikola',
  email: 'ccccs@koko.com',
  password: '123456'
)

20.times do
  
  giveaway =  user.giveaways.build(
    title: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraphs,
    location: Faker::Address.city,
  )
  img = %w[lamp.png couch.png noguchi_table.jpg].sample
  giveaway.images.attach(io: File.open(Rails.root.join("app/assets/images/#{img}")), filename: "#{img}") 

    rand(2..4).times do |c|
      giveaway.comments.build(
          body: Faker::Movies::Lebowski.quote,
          user_id: 1
        )
    end
  giveaway.save
end



puts 'Done!'