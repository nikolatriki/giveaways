# frozen_string_literal: true

class User < ApplicationRecord
  MAXIMUM_NAME_LENGTH = 50
  MAXIMUM_EMAIL_LENGTH = 250
  VALID_REGEX_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  MINIMUM_PASSWORD_LENGTH = 6

  before_save :email_to_downcase

  has_secure_password

  validates :name, presence: true, length: { maximum: MAXIMUM_NAME_LENGTH }
  validates :email, presence: true, length: { maximum: MAXIMUM_EMAIL_LENGTH },
                    format: { with: VALID_REGEX_EMAIL },
                    uniqueness: true
  validates :password, length: { minimum: MINIMUM_PASSWORD_LENGTH }

  private

  def email_to_downcase
    self.email = email.downcase
  end
end
