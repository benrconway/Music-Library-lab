require("pg")

class SqlRunner

  def SqlRunner.run(sql, values = [])
    begin
      db = PG.connect({ dbname: "music_collection", host: "localhost" })
      db.prepare("query", sql)
      pg_result = db.exec_prepared("query", values)
    ensure
      db.close
    end
    return pg_result
  end

end
