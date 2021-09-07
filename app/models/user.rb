# frozen_string_literal: true

class User < ApplicationRecord
  VALID_REGEX_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  before_save :email_to_downcase

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 250 },
                    format: { with: VALID_REGEX_EMAIL },
                    uniqueness: true

  private

  def email_to_downcase
    self.email = email.downcase
  end
end
