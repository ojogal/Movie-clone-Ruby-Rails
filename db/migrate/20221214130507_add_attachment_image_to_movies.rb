# frozen_string_literal: true

class AddAttachmentImageToMovies < ActiveRecord::Migration[7.0]
  def up
    add_column :movies, :image_file_name, :string
    add_column :movies, :image_file_size, :integer
    add_column :movies, :image_content_type, :string
    add_column :movies, :image_updated_at, :datetime
  end

  def down
    remove_column :movies, :image_file_name, :string
    remove_column :movies, :image_file_size, :integer
    remove_column :movies, :image_content_type, :string
    remove_column :movies, :image_updated_at, :datetime
  end
end
