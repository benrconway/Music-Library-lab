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

  def Album.all()
    sql = "SELECT * FROM albums;"
    pg_result = SqlRunner.run(sql)
    album_list = pg_result.map() { |album_hash| Album.new(album_hash)}
    return album_list
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1;"
    pg_result = SqlRunner.run(sql, [@artist_id])
    albums_by_artist = pg_result.map() {|artist_info| Artist.new(artist_info)}
    return albums_by_artist
  end

  def Album.delete_all()
    sql = "DELETE FROM albums;"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM albums WHERE id = $1;"
    SqlRunner.run(sql, [@id])
  end

  def Album.find_by_id(id)
    sql = "SELECT * FROM albums WHERE id = $1;"
    pg_result = SqlRunner.run(sql, [id])
    album = pg_result.map() {|album_info| Album.new(album_info)}
    return album
  end
end
