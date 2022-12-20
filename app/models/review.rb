class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :user_id, uniqueness: true

  validates :rating, numericality: { only_integer: true }, allow_blank: true
  validates :rating, inclusion: 1..10, allow_blank: true
end
