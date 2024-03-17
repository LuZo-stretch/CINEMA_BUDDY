class UsersController < ApplicationController
  def index
    liked_movies_ids = current_user.liked_movies.pluck(:movie_id)
    @users = User.includes(:liked_movies).where(liked_movies: { movie_id: liked_movies_ids })
    @users = @users.distinct

    # @users = User.all
    if params[:query].present?
      @users = @users.where("name ILIKE ?", "%#{params[:query]}%")
    end
    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :age, :description, :photo)
  end
end
