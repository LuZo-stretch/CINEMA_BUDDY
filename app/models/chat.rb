class Chat < ApplicationRecord
  belongs_to :user
  # user and match user
  belongs_to :user_match, class_name: "User"
  has_many :messages
  # validate that the same user and match only have one chat
end
