class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_one_attached :photo
  has_many :matches
  has_many :matched_users, through: :matches, source: 'user_match'
  has_many :liked_movies
  # acts_as_favoritor
  has_one :profile


  def liked_me?(user_match)
    # the other user likes me and the pending is true
    Match.exists?(user_id: user_match.id, user_match_id: id, pending: true)
  end

  def liked_me_back?(user_match)
    # users that i started a match and is pending
    Match.exists?(user_id: id, user_match_id: user_match.id, pending: true)
  end

  def get_match_id(user_match)
    if liked_me?(user_match)
      return Match.find_by(user_id: user_match.id, user_match_id: id).id
    elsif liked_me_back?(user_match)
      return Match.find_by(user_id: id, user_match_id: user_match.id).id
    end

    return false
  end
end
