class MoviesController < ApplicationController
  require 'open-uri'
  require 'json'

  before_action :authenticate_user!, only: :toggle_favorite

  def index
    # api_url = "https://api-gate2.movieglu.com/"
    # api_response = URI.open(api_url).read
    # result = JSON.parse(api_response)

    results = URI.open("https://api-gate2.movieglu.com/filmsNowShowing/?n=10",
      "client" => "FBSX",
      "x-api-key" => "6TgeI2l96260XmJvAow2c7XGsSvGlgyi8OcGfcTh",
      "authorization" => "Basic RkJTWF9YWDpTdE0xMmkzTlRJSkc=",
      "territory" => "XX",
      "api-version" => "v200",
      "geolocation" => "-22.0;14.0",
      "device-datetime" => "2024-03-11T18:47:00.000Z").read

    movies = JSON.parse(results)

    movies["films"].each do |movie_data|
      movie = Movie.create(
        title: movie_data["film_name"],
        synopsis: movie_data["synopsis_long"],
        photo_url: movie_data["images"]["poster"]["1"]["medium"]["film_image"],
        trailer: movie_data["film_trailer"]
      )

      if movie.persisted?
        puts "Movie saved: #{movie.title}"
      else
        puts "Error saving movie: #{movie.errors.full_messages.join(", ")}"
      end
    end
    @movies = Movie.all
  end

  def show
    @movie = Movie.find_by(id: params[:id])
  end

  # def show
  #   @movie = Movie.find(params[:id])
  # end

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
