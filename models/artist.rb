require("pry-byebug")
require_relative("../db/sql_runner.rb")

class Artist

  attr_accessor(:name)
  attr_reader(:id)

  def initialize(artist_details)
    @id = artist_details["id"].to_i if artist_details["id"]
    @name = artist_details["name"]
  end

  def save()
    sql = "INSERT INTO artists (name)
        VALUES ($1) RETURNING id;"
    pg_result = SqlRunner.run(sql, [@name])
    artist_hash = pg_result.map() { |artist| Artist.new(artist)}
    @id = artist_hash[0].id.to_i()
  end

  def Artist.all()
    sql = "SELECT * FROM artists;"
    pg_result = SqlRunner.run(sql)
    artist_list = pg_result.map() { |artist_hash| Artist.new(artist_hash)}
    return artist_list
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = $1;"
    pg_result = SqlRunner.run(sql, [@id])
    albums_by_artist = pg_result.map() { |album_info| Album.new(album_info)}
    return albums_by_artist
  end

  def Artist.delete_all()
    sql = "DELETE FROM artists;"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM artists WHERE id = $1;"
    SqlRunner.run(sql, [@id])
  end

  def Artist.find_by_id(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    pg_result = SqlRunner.run(sql, [id])
    artist = pg_result.map() {|artist_info| Artist.new(artist_info)}
    return artist
  end
end
