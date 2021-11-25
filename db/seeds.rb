puts "Seeding started..."

user = User.build(
  name: 'nikola',
  email: 'user@test.com',
  password: 'password'
)
user.save

30.times do

  giveaway =  user.giveaways.build(
    title: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraphs,
    location: Faker::Address.city,
  )
  giveaway.save

  # img = %w[lamp.jpg seat.jpg].sample
  # pic = Picture.build(
  #   title: img[0..-5],
  #   giveaway_id: giveaway.id
  # )
  # pic.save

  # pic.image.attach(io: File.open(Rails.root.join("app/assets/images/#{img}")), filename: "#{img}")

  rand(2..5).times do |c|
    giveaway.comments.build(
        body: Faker::Movies::Lebowski.quote,
        user_id: rand(1..User.count)
      )

    giveaway.save
  end

end

puts 'Done!'
