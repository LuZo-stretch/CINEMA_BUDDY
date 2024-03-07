class CinemasController < ApplicationController
  def index
    @cinemas = Cinema.all
    @markers = @cinemas.geocoded.map do |cinema|
      {
        lat: cinema.latitude,
        lng: cinema.longitude
      }
    end
  end
end
