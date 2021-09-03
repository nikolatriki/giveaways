# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  30.times do
    Giveaway.create(
    title: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraphs,
    location: Faker::Address.city
    )
  end

  Giveaway.all.each do |givey|
    2.times do
      givey.comments.create(
        commenter: Faker::Movies::Lebowski.character,
        body: Faker::Movies::Lebowski.quote
      )
    end
  end

 puts 'Done!'