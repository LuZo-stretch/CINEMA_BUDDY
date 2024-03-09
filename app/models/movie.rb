class Movie < ApplicationRecord
  has_one_attached :photo
  acts_as_favoritable
end
