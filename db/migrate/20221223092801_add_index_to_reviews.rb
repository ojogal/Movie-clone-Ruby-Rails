# frozen_string_literal: true

class AddIndexToReviews < ActiveRecord::Migration[7.0]
  def change
    add_index :reviews, %i[movie_id user_id], unique: true
  end
end
