require 'factory_bot_rails'
include FactoryBot::Syntax::Methods

puts "Seeding started..."

rand(2..5).times do |i|
  user = create(:user)


  rand(4..7).times do |n|
    giveaway = create(:giveaway, user: user)

      img = %w[lamp.jpg seat.jpg].sample
      pic = Picture.create(
        title: img[0..-5],
        giveaway_id: giveaway.id
      )

      pic.image.attach(io: File.open(Rails.root.join("app/assets/images/#{img}")), filename: "#{img}")

      rand(2..5).times do |c|
        giveaway.comments.create!(
            body: Faker::Movies::Lebowski.quote,
            user_id: rand(1..User.count)
          )
      end
  end
end

puts 'Done!'
