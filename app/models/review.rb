# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :rating, numericality: { only_integer: true }, allow_blank: true
  validates :rating, inclusion: 1..5, allow_blank: true
end
