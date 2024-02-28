class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :synopsis
      t.integer :rating
      t.string :trailer
      t.date :end_date
      t.string :photo_url

      t.timestamps
    end
  end
end
