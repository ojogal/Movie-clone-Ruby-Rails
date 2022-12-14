class Movie < ApplicationRecord
  validates :rating, numericality: { only_integer: true }, allow_blank: true
  validates :rating, inclusion: 1..10, allow_blank: true
  validates :image, presence: true
  validates :title, presence: true, uniqueness: true
  validates :text, presence: true, uniqueness: true
  validates :category, presence: true
  belongs_to :user

  has_attached_file :image, styles: { medium: "400x600#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
