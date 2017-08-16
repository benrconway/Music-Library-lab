require_relative("../db/sql_runner.rb")

class Album

  attr_accessor(:title, :genre)
  attr_reader(:artist_id, :id)

  def initialize(album_details)
    @id = album_details["id"].to_i if album_details["id"]
    @title = album_details["title"]
    @genre = album_details["genre"]
    @artist_id = album_details["artist_id"]
  end

  def save()
    sql = "
      INSERT INTO albums (title, genre, artist_id)
      VALUES ($1, $2, $3) RETURNING id;
    "
    values = [@title, @genre, @artist_id]
    pg_result = SqlRunner.run(sql, values)
    album_hash = pg_result.map() { |album_hash| Album.new(album_hash)}
    @id = album_hash[0].id.to_i()
  end

end
