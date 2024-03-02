class CreateCinemas < ActiveRecord::Migration[7.1]
  def change
    create_table :cinemas do |t|
      t.string :name
      t.string :address
      t.string :cinema_url
      t.integer :rating
      t.float :price

      t.timestamps
    end
  end
end
