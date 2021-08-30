# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :giveaway
  validates :commenter, :body, presence: true
end
