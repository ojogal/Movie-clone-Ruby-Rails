# frozen_string_literal: true

class User < ApplicationRecord
  has_many :movies
  has_many :reviews, dependent: :destroy

  validates :email, presence: true
  validates :email, uniqueness: true

  enum role: { basic: 0, admin: 1 }, _suffix: :role

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
