class Chat < ApplicationRecord
  belongs_to :match
  # user and match user
  has_many :messages, dependent: :destroy
  # validate that the same user and match only have one chat
end
