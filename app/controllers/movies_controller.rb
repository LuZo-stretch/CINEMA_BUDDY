class MoviesController < ApplicationController
  def show
    @movies = Movie.all
  end
end
