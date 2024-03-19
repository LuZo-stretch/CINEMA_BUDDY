class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.text :bio
      t.text :preferences
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
