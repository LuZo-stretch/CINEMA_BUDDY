class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_profile, only: [:show, :edit, :update]
  
    def show
    end
  
    def edit
    end
  
    def update
      if @profile.update(profile_params)
        redirect_to profile_path(current_user), notice: 'Profile updated successfully.'
      else
        render :edit
      end
    end
  
    private
  
    def set_profile
      @profile = current_user.profile # Assumes User `has_one :profile`
    end
  
    def profile_params
      params.require(:profile).permit(:bio, :preferences) # Adjust according to your profile attributes
    end
  end
  