class MatchesController < ApplicationController
  def create
    user_match = User.find_by(id: params[:user_match_id])

    # Check if there is a pending match for the other user
    pending_match = Match.find_by(user: current_user, user_match_id: user_match, pending: true)

    match = Match.new(user: current_user, user_match_id: user_match.id)

    if pending_match.present?
      # Both users have liked each other, create the actual match
      Match.create(user: current_user, user_match: user_match)
      pending_match.destroy # Remove the pending match
      match.save
      flash[:notice] = "The match was created"
      redirect_to user_path(user_match)
    else
      # Create a pending match
      Match.create(user: current_user, user_match: user_match, pending: true)
      redirect_to user_path(user_match)
      # head :ok
    end

    # if match.save
    #   # flash[:notice] = "The match was created"
    #   # redirect_to users_path
    #   head :ok
    # else
    #   head :unprocessable_entity
    # end
  end
end
