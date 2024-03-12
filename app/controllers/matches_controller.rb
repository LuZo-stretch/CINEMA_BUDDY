class MatchesController < ApplicationController
  def create
    raise
    user_match = User.find(params[:user_match_id])

    # Check if there is a pending match from the other user
    respond_to do |format|
      if current_user.matches_with?(user_match)
        match = Match.create(user_id: current_user.id, user_match_id: user_match.id, pending: false)
        Match.create(user_id: user_match.id, user_match_id: current_user.id, pending: false, match_id: match.id)

        # Notify users about the match
        format.html { redirect_to root_path }
        format.json
      else
        format.html { redirect_to root_path }
        format.json
      end
    end
  end

  def show
    @match = Match.find(params[:id])
    # Add any additional logic or data retrieval as needed
  end
end
    # user_match = User.find_by(id: params[:user_match_id])

    # # Check if there is a pending match for the other user
    # pending_match = Match.find_by(user: current_user, user_match: user_match)

    # # match = Match.new(user: current_user, user_match_id: user_match.id, pending: false)


    # if pending_match.present?
    #   # Both users have liked each other, create the actual match
    #   # match.pending = false
    #   Match.create(user: current_user, user_match: user_match, pending: false)
    #   pending_match.destroy # Remove the pending match
    #   # match.save
    #   flash[:notice] = "The match was created"
    #   # redirect_to user_path(user_match)
    # else
    #   # Create a pending match
    #   Match.create(user: current_user, user_match: user_match, pending: true)
    #   # redirect_to user_path(user_match)
    #   # head :ok
    # end
    # redirect_to user_path(user_match)

    # if match.save
    #   # flash[:notice] = "The match was created"
    #   # redirect_to users_path
    #   head :ok
    # else
    #   head :unprocessable_entity
    # end
