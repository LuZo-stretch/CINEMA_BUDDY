class ChangeChatAssociationFromMatchToUser < ActiveRecord::Migration[7.1]
  def change
    remove_reference :chats, :match, index: true, foreign_key: true
    add_reference :chats, :user, null: false, foreign_key: true
  end
end
