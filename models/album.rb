require_relative("../sql_runner.rb")

class Album

  attr_accessor(:title, :genre)
  attr_reader(:artist_id, :id)

  def initialize(album_details)
    @id = album_details["id"].to_i if album_details["id"]
    @title = album_details["title"]
    @genre = album_details["genre"]
    @artist_id = album_details["artist_id"]
  end

end
