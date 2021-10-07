# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    association :giveaway, factory: :giveaway
    association :user, factory: :user

    body { Faker::Lorem.sentences(number: 1) }
  end
end
