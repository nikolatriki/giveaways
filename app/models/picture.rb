class Picture < ApplicationRecord
  belongs_to :giveaway
  has_one_attached :image
end
