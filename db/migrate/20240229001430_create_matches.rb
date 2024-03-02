class CreateMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :matches do |t|
      t.references :user, null: false
      t.references :user_match, null: true

      t.timestamps
    end
    add_foreign_key :matches, :users, column: :user_id, primary_key: :id
    add_foreign_key :matches, :users, column: :user_match_id, primary_key: :id
  end
end
