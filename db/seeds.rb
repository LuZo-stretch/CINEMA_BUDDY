# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "open-uri"
require "json"

Movie.destroy_all

results = URI.open("https://api-gate2.movieglu.com/filmsNowShowing/?n=10",
  "client" => "FBSX",
  "x-api-key" => "r2k92sXJQh4sIyjkLQu1O80Uh0J41c7A46Dwtvi4",
  "authorization" => "Basic RkJTWDpSaDlKOGdXak9UTVQ=",
  "territory" => "UK",
  "api-version" => "v200",
  "geolocation" => "-22.0;14.0",
  "device-datetime" => "2024-03-20T18:47:00.000Z").read
movies = JSON.parse(results)

movies["films"].each do |movie_data|
  id = movie_data["film_id"]
  movie_results = URI.open("https://api-gate2.movieglu.com/filmDetails/?film_id=#{id}",
    "client" => "FBSX",
    "x-api-key" => "r2k92sXJQh4sIyjkLQu1O80Uh0J41c7A46Dwtvi4",
    "authorization" => "Basic RkJTWDpSaDlKOGdXak9UTVQ=",
    "territory" => "UK",
    "api-version" => "v200",
    "geolocation" => "-22.0;14.0",
    "device-datetime" => "2024-03-20T18:47:00.000Z").read
  movie_info = JSON.parse(movie_results)
  movie = Movie.create(
    title: movie_data["film_name"],
    synopsis: movie_data["synopsis_long"],
    photo_url: movie_data["images"]["poster"]["1"]["medium"]["film_image"],
    trailer: movie_data["film_trailer"],
    rating: movie_info["review_stars"],
    end_date: movie_info["show_dates"].last["date"]
  )

  if movie.persisted?
    puts "Movie saved: #{movie.title}"
  else
    puts "Error saving movie: #{movie.errors.full_messages.join(", ")}"
  end
end

# puts "Deleting everything..."
# LikedMovie.destroy_all
# Match.destroy_all
# Movie.destroy_all
# User.destroy_all

# puts "Creating users..."
# lucia = User.create!(name: "Lucia", email: "lucia@gmail.com", age: 41, description: "I like action, sci-fy and anime. I live with my cats and like to go to matinees.", password: "123456")
# ana = User.create!(name: "Ana", email: "ana@gmail.com", age: 39, description: "I like disaster movies and going out. My favorite place is the beach.", password: "123456")
# george = User.create!(name: "George", email: "george@gmail.com", age: 39, description: "I like action and war movies. My favorite is Indiana Jones. I like to play Risk and Monopoly if I am not watching movies.", password: "123456")
# joana = User.create!(name: "Joana", email: "joana@gmail.com", age: 35, description: "I like romcoms and eating popcorn when I go to the cinema. I love good food and talking about movies I have enjoyed.", password: "123456")


# puts "Creating movies..."
# harry_potter_file = URI.open("https://media.themoviedb.org/t/p/w500/wuMc08IPKEatf9rnMNXvIDxqP4W.jpg")
# harry_potter = Movie.new(title: "Harry Potter and the Philosopher's Stone", synopsis: "An orphaned boy enrolls in a school of wizardry, where he learns the truth about himself, his family and the terrible evil that haunts the magical world.", rating: 4 , trailer: "https://youtu.be/VyHV0BRtdxo?feature=shared", end_date: Date.new(2024, 6, 5))
# harry_potter.photo.attach(io: harry_potter_file, filename: "harry_potter.jpg", content_type: "image/jpg")
# harry_potter.save

# indiana_jones_file = URI.open("https://www.lucasfilm.com/app/uploads/IJ1_IA_1587_D-1-480x733.jpg")
# indiana_jones = Movie.new(title: "Raiders of the Lost Ark", synopsis: "In 1936, archaeologist and adventurer Indiana Jones is hired by the U.S. government to find the Ark of the Covenant before the Nazis can obtain its awesome powers.", rating: 3, trailer: "https://www.imdb.com/video/vi3747396377/?ref_=tt_vi_i_1", end_date: Date.new(2024, 9, 23))
# indiana_jones.photo.attach(io: indiana_jones_file, filename: "indiana_jones.jpg", content_type: "image/jpg")
# indiana_jones.save

# spirited_away_file = URI.open("https://m.media-amazon.com/images/M/MV5BMjlmZmI5MDctNDE2YS00YWE0LWE5ZWItZDBhYWQ0NTcxNWRhXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_.jpg")
# spirited_away = Movie.new(title: "Spirited Away", synopsis: "During her family's move to the suburbs, a sullen 10-year-old girl wanders into a world ruled by gods, witches and spirits, a world where humans are changed into beasts.", rating: 2, trailer: "https://www.imdb.com/video/vi3619684633/?ref_=tt_vi_i_1", end_date: Date.new(2024, 6, 23))
# spirited_away.photo.attach(io: spirited_away_file, filename: "spirited_away.jpg", content_type: "image/jpg")
# spirited_away.save

# suzume_file = URI.open("https://m.media-amazon.com/images/M/MV5BNGVkNDc3NjUtNTY5ZS00ZmE0LWE3YzctMDk2OTRlNTdiZWQwXkEyXkFqcGdeQXVyMTU3NDg0OTgx._V1_FMjpg_UX1000_.jpg")
# suzume = Movie.new(title: "Suzume", synopsis: "A modern action adventure road story where a 17-year-old girl named Suzume helps a mysterious young man close doors from the other side that are releasing disasters all over in Japan.", rating: 5, trailer: "https://www.imdb.com/video/vi3884303641/?ref_=tt_vi_i_1", end_date: Date.new(2024, 5, 11))
# suzume.photo.attach(io: suzume_file, filename: "suzume.jpg", content_type: "image/jpg")
# suzume.save

# meg_file = URI.open("https://m.media-amazon.com/images/M/MV5BMTAxMGRmODYtM2NkYS00ZGRlLWE1MWItYjI1MzIwNjQwN2RiXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_.jpg")
# meg = Movie.new(title: "The Meg", synopsis: "A group of scientists exploring the Marianas Trench encounter the largest marine predator that has ever existed - the Megalodon.", rating: 3, trailer: "https://www.imdb.com/video/vi3497834521/?ref_=tt_vi_i_1", end_date: Date.new(2024, 12, 4))
# meg.photo.attach(io: meg_file, filename: "meg.jpg", content_type: "image/jpg")
# meg.save

# puts "Creating liked_movies..."
# liked_1 = LikedMovie.create!(movie_id: harry_potter.id, user_id: lucia.id)
# liked_2 = LikedMovie.create!(movie_id: indiana_jones.id, user_id: george.id)
# liked_3 = LikedMovie.create!(movie_id: harry_potter.id, user_id: ana.id)
# liked_4 = LikedMovie.create!(movie_id: indiana_jones.id, user_id: joana.id)
# liked_5 = LikedMovie.create!(movie_id: meg.id, user_id: george.id)
# liked_6 = LikedMovie.create!(movie_id: meg.id, user_id: ana.id)
# liked_7 = LikedMovie.create!(movie_id: spirited_away.id, user_id: lucia.id)
# liked_8 = LikedMovie.create!(movie_id: spirited_away.id, user_id: joana.id)
# liked_9 = LikedMovie.create!(movie_id: suzume.id, user_id: lucia.id)
# liked_10 = LikedMovie.create!(movie_id: suzume.id, user_id: george.id)

# puts "Creating matches..."
# match_1 = Match.create!(user_id: lucia.id, user_match_id: ana.id)
# match_2 = Match.create!(user_id: george.id, user_match_id: joana.id)
# match_3 = Match.create!(user_id: ana.id, user_match_id: george.id)
# match_4 = Match.create!(user_id: joana.id, user_match_id: lucia.id)
# match_5 = Match.create!(user_id: lucia.id, user_match_id: george.id)

# puts "All done!"
