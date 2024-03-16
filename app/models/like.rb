class Like < ApplicationRecord
  belongs_to :liker
  belongs_to :liked
end
