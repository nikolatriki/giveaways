# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :giveaways, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :claims, dependent: :destroy

  validates :name, presence: true
  validates :email, email: { mode: :strict }

  protected

  def confirmation_required?
    true # change to false if you want to disable email confirmations
  end
end
