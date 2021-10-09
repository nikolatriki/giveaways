# frozen_string_literal: true

class Giveaway < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user
  has_many_attached :images, dependent: :destroy

  validates :title, :description, :location, presence: true, length: { minimum: 5 }
end
