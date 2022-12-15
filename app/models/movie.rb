class Movie < ApplicationRecord
  belongs_to :user, optional: true

  validates :rating, numericality: { only_integer: true }, allow_blank: true
  validates :rating, inclusion: 1..10, allow_blank: true
  validates :title, uniqueness: true
  validates :text, uniqueness: true

  has_attached_file :image, styles: { medium: "400x600#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  paginates_per 8

  scope :filter_by_category, lambda { |keyword|
    where('lower(category) LIKE ?', "%#{keyword.downcase}%")
  }

  def self.search(search)
    movies = search ? Movie.filter_by_category(search) : Movie.all
    movies
  end
end
