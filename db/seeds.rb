require 'factory_bot_rails'
include FactoryBot::Syntax::Methods

puts "Seeding started..."

puts "Seeding users and giveaways..."
create(:user, email: 'user@test.com', password: 'password', password_confirmation: 'password')
rand(4..6).times do
  user = create(:user)


  rand(4..7).times do
    giveaway = create(:giveaway, user: user)

      img = %w[lamp.jpg seat.jpg].sample
      pic = Picture.create(
        title: img[0..-5],
        giveaway_id: giveaway.id
      )

      pic.image.attach(io: File.open(Rails.root.join("app/assets/images/#{img}")), filename: "#{img}")

      rand(2..5).times do
        giveaway.comments.create!(
            body: Faker::Movies::Lebowski.quote,
            user_id: rand(1..User.count)
          )
      end
  end
end

puts "Seeding claims..."
rand(30..35).times do
  create(:claim, giveaway_id: rand(1..Giveaway.count), user_id: rand(1..User.count)) rescue next
end

puts 'Done!'
