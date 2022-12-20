class Movie < ApplicationRecord
  belongs_to :user#, optional: true
  has_many :reviews
  validates :title, uniqueness: true, presence: :true
  validates :text, uniqueness: true, presence: :true

  has_attached_file :image, styles: { medium: "400x600#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/, presence: :true

  paginates_per 8

  scope :filter_by_category, lambda { |keyword|
    where('lower(category) LIKE ?', "%#{keyword.downcase}%")
  }

  def self.search(search)
    movies = search ? Movie.filter_by_category(search) : Movie.all
    movies
  end

  def avg_ratings
    if reviews.blank?
      @avg_ratings = 0
    else
      @avg_ratings = reviews.average(:rating).round(2)
    end
    @avg_ratings
  end
end
