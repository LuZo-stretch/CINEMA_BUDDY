class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo
  has_many :matches
  has_many :matched_users, through: :matches, source: 'user_match'

  acts_as_favoritor

  def matches_with?(user_match)
    Match.exists?(user_id: id, user_match_id: user_match.id, pending: false)
  end
end
