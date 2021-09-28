# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :giveaway, :user
  validates :body, presence: true
end
