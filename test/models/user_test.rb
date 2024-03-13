require "test_helper"

class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  after_commit :create_user_profile, on: :create

  private

  def create_user_profile
    create_profile unless profile.present?
  end
end
