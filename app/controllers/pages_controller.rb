class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]
  before_action :authenticate_user!, only: [:profile]
  def home
    # @hide_navbar = true
  end
  def profile
    @user = current_user
  end
end
