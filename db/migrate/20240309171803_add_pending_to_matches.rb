class AddPendingToMatches < ActiveRecord::Migration[7.1]
  def change
    add_column :matches, :pending, :boolean, default: true
  end
end
