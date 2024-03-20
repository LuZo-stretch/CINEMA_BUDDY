class MatchesController < ApplicationController
  def create
    user_match = User.find(params[:user_match_id])

    if current_user.liked_me?(user_match) # Checking if the user has already tried to match me then this will be confirming the match
      match = Match.find_by(user_id: user_match.id, user_match_id: current_user.id)
      match.pending = false
      match.save!
      render json: { matched: true }
    elsif current_user.liked_me_back?(user_match) # cancel my match that hasn't been confirmed
      match = Match.find_by(user_id: current_user.id, user_match_id: user_match.id)
      match.destroy
      render json: { matched: false }
    else # Create a new match request
      match = Match.create(user_id: current_user.id, user_match_id: user_match.id, pending: true)
      render json: { matched: false }
    end
    # rescue ActiveRecord::RecordNotFound => e
    # render json: { error: e.message }, status: :not_found
  end

  def show
    @match = Match.find(params[:id])
  end
end
