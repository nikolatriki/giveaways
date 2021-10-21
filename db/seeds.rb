puts "Seeding started..."

user = User.create(
  name: 'nikola',
  email: 'user@test.com',
  password: 'password'
)

20.times do

  giveaway =  user.giveaways.create(
    title: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraphs,
    location: Faker::Address.city,
  )

  img = %w[lamp.png couch.png noguchi_table.jpg].sample
  pic = Picture.create(
    title: img[0..-5],
    giveaway_id: giveaway.id
  )
  pic.image.attach(io: File.open(Rails.root.join("app/assets/images/#{img}")), filename: "#{img}")

  rand(2..4).times do |c|
    giveaway.comments.create(
        body: Faker::Movies::Lebowski.quote,
        user_id: 1
      )
  end

end

puts 'Done!'
