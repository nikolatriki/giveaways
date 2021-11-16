# frozen_string_literal: true

FactoryBot.define do
  factory :picture do
    association :giveaway, factory: :giveaway
  end
end
