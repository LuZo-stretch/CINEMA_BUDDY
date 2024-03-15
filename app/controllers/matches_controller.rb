class MatchesController < ApplicationController
  def create
    user_match = User.find(params[:user_match_id])

    if current_user.matches_with?(user_match)
      match = Match.find_by(user_id: current_user.id, user_match_id: user_match.id) || Match.find_by(user_id: user_match.id, user_match_id: current_user.id)
      match.pending = false
      match.save!
      render json: { matched: true, match_id: match.id }
    else
      match = Match.create(user_id: current_user.id, user_match_id: user_match.id, pending: true)
      render json: { matched: false, match_id: match.id }
    end
    # rescue ActiveRecord::RecordNotFound => e
      # render json: { error: e.message }, status: :not_found
  end

  def show
    @match = Match.find(params[:id])
  end
end
