class User < ApplicationRecord
  has_many :movies
  has_many :reviews, dependent: :destroy
    
  enum role: { basic: 0, admin: 1 }, _suffix: :role

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
