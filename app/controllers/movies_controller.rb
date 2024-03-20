class MoviesController < ApplicationController
  require 'open-uri'
  require 'json'

  before_action :authenticate_user!, only: :toggle_favorite

  def index
    # api_url = "https://api-gate2.movieglu.com/"
    # api_response = URI.open(api_url).read
    # result = JSON.parse(api_response)
    if params[:query].present?
      @movies = Movie.search_by_title_and_synopsis("%#{params[:query]}%")
    else
      @movies = Movie.all
    end
    # use pg search
  end

  def show
    @movie = Movie.find_by(id: params[:id])
    if @movie.nil?
      redirect_to movies_path, alert: "Movie not found."
    else
      @liked_movie = LikedMovie.find_by(movie: @movie, user: current_user) if user_signed_in?
    end
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
