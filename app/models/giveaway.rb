# frozen_string_literal: true

class Giveaway < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user
  has_many_attached :images

  validates :title, :description, :location, presence: true, length: { minimum: 5 }
  validates :images, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']
end
