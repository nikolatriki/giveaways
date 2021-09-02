# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    giveaway

    commenter { Faker::Name.name }
    body { Faker::Lorem.sentences(number: 1) }
  end
end
