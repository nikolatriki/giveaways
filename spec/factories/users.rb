# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) { |i| "user-#{i}@email.com" }
    password { '123456' }
    password_confirmation { '123456' }
  end
end
