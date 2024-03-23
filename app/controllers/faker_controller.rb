class FakerController < ApplicationController

  # def index
  #   liked_movies_ids = current_user.liked_movies.pluck(:movie_id)
  #   @users = User.includes(:liked_movies).where(liked_movies: { movie_id: liked_movies_ids }) # checking they have the same movies
  #   users = users.where.not(user: current_user) #current_user not included
  #   check that they are not a current match users = users + filter of having a match - match instance with pending = false. for current_user
  #   @users = @users.distinct

  #   @users = User.all
  #   if params[:query].present?
  #     @users = @users.where("name ILIKE ?", "%#{params[:query]}%")
  #   end
  #   respond_to do |format|
  #     format.html
  #     format.json { render json: @users }
  #   end
  # end

  def index
    liked_movies_ids = current_user.liked_movies.pluck(:movie_id)
    users = User.includes(:liked_movies).where(liked_movies: { movie_id: liked_movies_ids }) # checking they have the same movies
    users = users.where.not(id: current_user.id) #current_user not included
    users = users.where.not(id: Match.where(user_id: current_user.id).or(Match.where(user_match_id: current_user.id, pending: false)))# check that they are not a current match users = users + filter of having a match - match instance with pending = false for current_user
    @users = users.distinct

    # @users = User.all
    if params[:query].present?
      @users = @users.where("name ILIKE ?", "%#{params[:query]}%")
    end
    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end
end
