# frozen_string_literal: true

class Giveaway < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :pictures, dependent: :destroy
  belongs_to :user

  validates :title, :description, :location, presence: true, length: { minimum: 5 }

  accepts_nested_attributes_for :pictures, allow_destroy: true

  def self.search(attribute)
    attribute ? where('location ILIKE ? OR title ILIKE ?', "%#{attribute[:giveaway]}%", "%#{attribute[:giveaway]}%") : all
  end
end
