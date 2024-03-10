class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user), notice: 'Profile created successfully!'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :age, :description, :photo)
  end
end