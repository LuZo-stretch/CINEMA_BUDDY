class LikedMoviesController < ApplicationController
  def create
    @liked_movie = LikedMovie.new
    @movie = Movie.find(params[:movie_id])
    @liked_movie.movie = @movie
    @liked_movie.user = current_user
    @liked_movie.save!
    redirect_to movies_path
  end

  def destroy

  end
end
