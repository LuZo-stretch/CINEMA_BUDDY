class MatchesController < ApplicationController
  def create
    user_match = User.find(params[:user_match_id])

    unless current_user.matches_with?(user_match)
      match = Match.create(user_id: current_user.id, user_match_id: user_match.id, pending: false)
      render json: { matched: true, match_id: match.id }
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def show
    @match = Match.find(params[:id])
  end
end
