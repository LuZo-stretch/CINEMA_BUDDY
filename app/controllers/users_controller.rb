class UsersController < ApplicationController
  def index
    @users = User.all
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
