# frozen_string_literal: true

class Claim < ApplicationRecord
  belongs_to :giveaway
  belongs_to :user

  validates :user_id, uniqueness: { scope: :giveaway_id }
end
