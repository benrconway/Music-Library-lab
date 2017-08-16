require("pry-byebug")
require_relative("../models/artist.rb")
require_relative("../models/album.rb")

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({"name" => "Freddy Mercury"})
artist2 = Artist.new({"name" => "Primal Scream"})
artist3 = Artist.new({"name" => "Presidents of the United States of America"})


artist1.save
artist2.save
artist3.save

album1 = Album.new({
    "title" => "Messenger of the Gods: The Singles",
    "genre" => "Pop Rock/Opera",
    "artist_id" => artist1.id,
  })

album2 = Album.new({
      "title" => "Queen",
      "genre" => "Pop Rock/Opera",
      "artist_id" => artist1.id,
    })

album3 = Album.new({
  "title" => "Screamadelica",
  "genre" => "Alternative Rock",
  "artist_id" => artist2.id,
  })

album4 = Album.new({
    "title" => "Presidents of the United States of America",
    "genre" => "Alternative Rock",
    "artist_id" => artist3.id,
    })


album1.save
album2.save
album3.save
album4.save


album_list = Album.all()

artist_list = Artist.all()
binding.pry
nil
