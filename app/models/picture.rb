# frozen_string_literal: true

class Picture < ApplicationRecord
  belongs_to :giveaway
  has_one_attached :image

  validates :image, content_type: %w[image/png image/jpg image/jpeg]
end
