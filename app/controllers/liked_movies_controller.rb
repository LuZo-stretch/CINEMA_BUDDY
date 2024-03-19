class LikedMoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie, only: [:create, :destroy]


  def create
    @liked_movie = current_user.liked_movies.build(movie: @movie)

    respond_to do |format|
      if @liked_movie.save
        format.json { render json: { liked: true, liked_id: @liked_movie.id }, status: :created }
        format.html { redirect_to movies_path }
      else
        format.json { render json: @liked_movie.errors, status: :unprocessable_entity }
        format.html { redirect_to movies_path, alert: 'Unable to like movie.' }
      end
    end
    # @liked_movie = LikedMovie.new
    # @movie = Movie.find(params[:movie_id])
    # @liked_movie.movie = @movie
    # @liked_movie.user = current_user
    # @liked_movie.save!
    # redirect_to movies_path
  end

  def destroy
    @liked_movie = current_user.liked_movies.find_by(movie: @movie)

    respond_to do |format|
      if @liked_movie&.destroy
        format.json { head :no_content }
        format.html { redirect_to movies_path }
      else
        format.json { render json: { error: 'Not found' }, status: :not_found }
        format.html { redirect_to movies_path, alert: 'Unable to unlike movie.' }
      end
    end
  end

  private

  def set_movie
    @movie = Movie.find_by(id: params[:movie_id])
    unless @movie
      respond_to do |format|
        format.json { render json: { error: 'Movie not found' }, status: :not_found }
        format.html { redirect_to movies_path, alert: 'Movie not found.' }
      end
    end
  end
end
