# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Creating users..."
lucia = User.create!(name: "Lucia", email: "lucia@gmail.com", age: 41, description: "I like action, sci-fy and anime. I live with my cats and like to go to matinees.")
ana = User.create!(name: "Ana", email: "ana@gmail.com", age: 39, description: "I like disaster movies and going out. My favorite place is the beach.")
george = User.create!(name: "George", email: "george@gmail.com", age: 39, description: "I like action and war movies. My favorite is Indiana Jones. I like to play Risk and Monopoly if I am not watching movies.")
joana = User.create!(name: "Joana", email: "joana@gmail.com", age: 35, description: "I like romcoms and eating popcorn when I go to the cinema. I love good food and talking about movies I have enjoyed.")

puts "Creating cinemas..."
picturehouse_central = Cinema.create!(name: "Picturehouse Central", address: "15 Great Windmill Street, London", cinema_url: "https://www.picturehouses.com")
curzon_soho = Cinema.create!(name: "Curzon Soho", address: "99 Shaftesbury Avenue, London", cinema_url: "https://www.curzon.com")
vue_westend = Cinema.create!(name: "Vue Cinema London - West End", address: "3 Cranbourn Street, London", cinema_url: "https://www.myvue.com")
vue_piccadilly = Cinema.create!(name: "Vue Cinema London - Piccadilly", address: "19 Lower Regent Street, London", cinema_url: "https://www.myvue.com")

puts "Creating movies..."
harry_potter_1 = Movie.create!(title: "Harry Potter and the Philosopher's Stone", synopsis: "An orphaned boy enrolls in a school of wizardry, where he learns the truth about himself, his family and the terrible evil that haunts the magical world.", rating: 8 , trailer: "https://www.imdb.com/video/vi3115057433/?ref_=tt_vi_i_1", end_date: Date.new(2024, 6, 5), photo_url:"harry_potter.jpg")
indiana_jones_1 = Movie.create!(title: "Raiders of the Lost Ark", synopsis: "In 1936, archaeologist and adventurer Indiana Jones is hired by the U.S. government to find the Ark of the Covenant before the Nazis can obtain its awesome powers.", rating: 9, trailer: "https://www.imdb.com/video/vi3747396377/?ref_=tt_vi_i_1", end_date: Date.new(2024, 9, 23), photo_url: "indiana_jones.jpg")
spirited_away = Movie.create!(title: "Spirited Away", synopsis: "During her family's move to the suburbs, a sullen 10-year-old girl wanders into a world ruled by gods, witches and spirits, a world where humans are changed into beasts.", rating: 9, trailer: "https://www.imdb.com/video/vi3619684633/?ref_=tt_vi_i_1", end_date: Date.new(2024, 6, 23), photo_url: "spirited_away.jpg")
suzume = Movie.create!(title: "Suzume", synopsis: "A modern action adventure road story where a 17-year-old girl named Suzume helps a mysterious young man close doors from the other side that are releasing disasters all over in Japan.", rating: 9, trailer: "https://www.imdb.com/video/vi3884303641/?ref_=tt_vi_i_1", end_date: Date.new(2024, 5, 11), photo_url: "suzume.jpg")
meg = Movie.create!(title: "The Meg", synopsis: "A group of scientists exploring the Marianas Trench encounter the largest marine predator that has ever existed - the Megalodon.", rating: 6, trailer: "https://www.imdb.com/video/vi3497834521/?ref_=tt_vi_i_1", end_date: Date.new(2024, 12, 4), photo_url: "meg.jpg")

puts "Creating liked_movies..."
liked_1 = Liked_movie.create!(movie_id: harry_potter_1.id, user_id: lucia.id)
liked_2 = Liked_movie.create!(movie_id: indiana_jones_1.id, user_id: george.id)
liked_3 = Liked_movie.create!(movie_id: harry_potter_1.id, user_id: ana.id)
liked_4 = Liked_movie.create!(movie_id: indiana_jones_1.id, user_id: joana.id)
liked_5 = Liked_movie.create!(movie_id: meg.id, user_id: george.id)
liked_6 = Liked_movie.create!(movie_id: meg.id, user_id: ana.id)
liked_7 = Liked_movie.create!(movie_id: spirited_away.id, user_id: lucia.id)
liked_8 = Liked_movie.create!(movie_id: spirited_away.id, user_id: joana.id)
liked_9 = Liked_movie.create!(movie_id: suzume.id, user_id: lucia.id)
liked_10 = Liked_movie.create!(movie_id: suzume.id, user_id: george.id)

puts "Creating matches..."
match_1 = Match.create!(user_id: lucia.id, user_match_id: ana.id)
match_2 = Match.create!(user_id: george.id, user_match_id: joana.id)
match_3 = Match.create!(user_id: ana.id, user_match_id: george.id)
match_4 = Match.create!(user_id: joana.id, user_match_id: lucia.id)
match_5 = Match.create!(user_id: lucia.id, user_match_id: george.id)

puts "Creating cinema_shows..."
curzon1 = Cinema_show.create!(cinema_id: curzon_soho.id, movie_id: harry_potter_1.id)
curzon2 = Cinema_show.create!(cinema_id: curzon_soho.id, movie_id: indiana_jones_1.id)
picturehouse1 = Cinema_show.create!(cinema_id: picturehouse_central.id, movie_id: spirited_away.id)
picturehouse2 = Cinema_show.create!(cinema_id: picturehouse_central.id, movie_id: meg.id)
vue1 = Cinema_show.create!(cinema_id: vue_westend.id, movie_id: suzume.id)
vue2 = Cinema_show.create!(cinema_id: vue_westend.id, movie_id: meg.id)
vue3 = Cinema_show.create!(cinema_id: vue_piccadilly.id, movie_id: spirited_away.id)

puts "All done!"
