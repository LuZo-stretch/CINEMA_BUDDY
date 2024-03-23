class Match < ApplicationRecord
  belongs_to :user
  belongs_to :user_match, class_name: "User"
  has_many :chats

  validates :user_match_id, uniqueness: { scope: :user_id }
  scope :pending, -> { where(pending: true) }
end
