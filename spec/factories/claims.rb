# frozen_string_literal: true

FactoryBot.define do
  factory :claim do
    association :giveaway, factory: :giveaway
    association :user, factory: :user
  end
end
