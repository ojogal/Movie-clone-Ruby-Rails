class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :text
      t.string :category

      t.timestamps
    end
  end
end
