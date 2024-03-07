class CinemasController < ApplicationController
  def index
    @cinemas = Cinema.all
    @markers = @cinemas.geocoded.map do |cinema|
      {
        lat: cinema.latitude,
        lng: cinema.longitude,
        info_window: render_to_string(partial: "info_window", locals: { cinema: cinema})
      }
    end
  end
end
