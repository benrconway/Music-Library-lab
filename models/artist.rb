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

end
