# frozen_string_literal: true

FactoryBot.define do
  factory :giveaway do
    user

    title { Faker::Commerce.product_name }
    description { Faker::Lorem.sentences(number: 1) }
    location { Faker::Address.city }
  end
end
