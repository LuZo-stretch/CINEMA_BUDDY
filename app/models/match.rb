class Match < ApplicationRecord
  belongs_to :user
  belongs_to :user_match, class_name: "User"
end
