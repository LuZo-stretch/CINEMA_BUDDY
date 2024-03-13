require "test_helper"

class Profile < ApplicationRecord
  belongs_to :user
end
