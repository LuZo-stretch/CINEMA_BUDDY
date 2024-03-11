class Match < ApplicationRecord
  belongs_to :user
  belongs_to :user_match, class_name: "User"

  validates :user_match_id, uniqueness: { scope: :user_id }
end
