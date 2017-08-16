require("pg")

class SqlRunner

  def run(sql, values = [])
    begin
      db = PG.connect({ dbname: "music_collection", host: "localhost" })
      db.prepare("command", sql)
      pg_result = db.exec_prepared("command", values)
    ensure
      db.close
    end
    return pg_result
  end

end
