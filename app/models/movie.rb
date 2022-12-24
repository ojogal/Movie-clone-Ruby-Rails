# frozen_string_literal: true

class Movie < ApplicationRecord
  belongs_to :user
  has_many :reviews

  before_validation :normalize_category, on: :create

  validates :title, uniqueness: true, presence: true
  validates :text, uniqueness: true, presence: true

  has_attached_file :image, styles: { medium: '400x600#' }
  validates_attachment_content_type :image, content_type: %r{\Aimage/.*\z}, presence: true

  paginates_per 8

  scope :filter_by_category, lambda { |keyword|
    where('lower(category) LIKE ?', "%#{keyword.downcase}%")
  }

  def avg_ratings
    @avg_ratings = if reviews.blank?
                     0
                   else
                     reviews.average(:rating).round(2).to_f
                   end
    @avg_ratings
  end

  private

  def normalize_category
    self.category = category.downcase.titleize
  end

  def self.search(search)
    search ? Movie.filter_by_category(search) : Movie.all
  end
end
