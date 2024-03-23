class MatchesController < ApplicationController
  def create

    user_match = User.find(params[:match])
    @user_match = user_match
    puts current_user
    respond_to do |format|
      if current_user.liked_me?(user_match) # Checking if the user has already tried to match me then this will be confirming the match
        match = Match.find_by(user_id: user_match.id, user_match_id: current_user.id)
        match.pending = false
        match.save!
        @matched = true
        @chat = Chat.create(match_id: match.id)
        format.html { redirect_to users_path }
        format.json

        # render json: { matched: true }
      elsif current_user.liked_me_back?(user_match) # cancel my match that hasn't been confirmed
        match = Match.find_by(user_id: current_user.id, user_match_id: user_match.id)
        match.destroy
        @matched = false
        format.html { redirect_to users_path }
        format.json
        # render json: { matched: false }
      else # Create a new match request
        match = Match.create(user_id: current_user.id, user_match_id: user_match.id, pending: true)
        @matched = false
        @match_id = match.id
        format.html { redirect_to users_path, alert: 'Unable to like profile.' }
        format.json

        # render json: { matched: false, match_id: match.id }
      end
    end
  end

  def show
    @match = Match.find(params[:id])
  end
end
