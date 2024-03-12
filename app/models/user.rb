class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo
  has_many :matches
  has_many :matched_users, through: :matches, source: 'user_match'

  acts_as_favoritor

  private

  def skip_password_validation
    self.password = Devise.friendly_token[0, 20] if password.blank?
  end

  protected

  def password_required?
    new_record? ? false : super
  end
end
