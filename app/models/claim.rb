class Claim < ApplicationRecord
  belongs_to :giveaway
  belongs_to :user
end
