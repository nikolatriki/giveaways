# frozen_string_literal: true

class Giveaway < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user
  has_many_attached :images, dependent: :destroy

  validates :title, :description, :location, presence: true, length: { minimum: 5 }
  validate :image_validation

  private

  def image_validation
    if images.attached? && !images.content_type.in?(%w[images/jpeg images/jpg images/png])
      images.purge # delete the uploaded file
      errors.add(:images, 'Must be a jpeg, jpg or png image file')
    end
  end
end
