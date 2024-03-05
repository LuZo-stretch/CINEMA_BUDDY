class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  before_validation :skip_password_validation, on: :create

  private

  def skip_password_validation
    self.password = Devise.friendly_token[0, 20] if password.blank?
  end

  protected

  def password_required?
    new_record? ? false : super
  end
end
