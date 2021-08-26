# frozen_string_literal: true

class Giveaway < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5 }
end
