require("pry-byebug")
require_relative("../models/artist.rb")
require_relative("../models/album.rb")

artist1 = Artist.new({"name" => "Freddy Mercury"})


artist1.save

album1 = Album.new({
    "title" => "Messenger of the Gods: The Singles",
    "genre" => "Pop Rock/Opera",
    "artist_id" => artist1.id,
  })

album1.save

binding.pry
nil
