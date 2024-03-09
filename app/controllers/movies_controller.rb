class MoviesController < ApplicationController
  before_action :authenticate_user!, only: :toggle_favorite
  def index
    @movies = Movie.all
    @movie = Movie.find_by(id: params[:id])
  end

  def show
    @movie = Movie.find_by(id: params[:id])
  end

  def toggle_favorite
    @movie = Movie.find_by(id: params[:id])
    if @movie
      current_user.favorited?(@movie) ? current_user.unfavorite(@movie) : current_user.favorite(@movie)
      head :ok
    else
      head :not_found
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:id)
  end
end
