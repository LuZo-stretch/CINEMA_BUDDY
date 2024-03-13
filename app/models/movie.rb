class Movie < ApplicationRecord
  has_one_attached :photo
  has_many :liked_movies, dependent: :destroy
  acts_as_favoritable
end
