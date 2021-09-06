# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do
  giveaway =  Giveaway.create(
    title: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraphs,
    location: Faker::Address.city
    )

    rand(2..4).times do |c|
      giveaway.comments.create(
          commenter: Faker::Movies::Lebowski.character,
          body: Faker::Movies::Lebowski.quote
        )
    end
end

puts 'Done!'