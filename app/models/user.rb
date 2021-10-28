# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :giveaways, dependent: :destroy
  has_many :comments, dependent: :nullify

  validates :name, presence: true
  validates :email, email: { mode: :strict }
end
