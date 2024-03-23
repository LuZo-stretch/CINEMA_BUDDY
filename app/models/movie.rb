class Movie < ApplicationRecord
  has_one_attached :photo
  has_many :liked_movies, dependent: :destroy
  acts_as_favoritable
  include PgSearch::Model
pg_search_scope :search_by_title_and_synopsis,
  against: [ :title, :synopsis ],
  using: {
    tsearch: { prefix: true } # <-- now `superman batm` will return something!
  }
end
