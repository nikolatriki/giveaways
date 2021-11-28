puts "Seeding started..."

user1 = User.create(
  name: 'nikola',
  email: 'user1@test.com',
  password: 'password'
)

user2 = User.create(
  name: 'dejan',
  email: 'user2@test.com',
  password: 'password'
)

10.times do

  giveaway =  user.giveaways.build(
    title: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraphs,
    location: Faker::Address.city,
  )
  giveaway.save

  img = %w[lamp.jpg seat.jpg].sample
  pic = Picture.create(
    title: img[0..-5],
    giveaway_id: giveaway.id
  )

  pic.image.attach(io: File.open(Rails.root.join("app/assets/images/#{img}")), filename: "#{img}")

  rand(2..5).times do |c|
    giveaway.comments.build(
        body: Faker::Movies::Lebowski.quote,
        user_id: rand(1..User.count)
      )

    giveaway.save
  end

end

puts 'Done!'
