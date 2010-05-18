module ImportEverything
  class SqliteParser < Parser
    fattr(:filfename) do
      f = Tempfile.new('somedb.sqlite3')
      f.binmode
      f << file.read
      f.path
    end
    fattr(:db) do
      gem 'sqlite3-ruby'
      require 'sqlite3'
      #raise "#{filename} #{file.local_methods.inspect}"
      res = SQLite3::Database.new(filename) 
      #get_raw_tables(res)
      #res
    end
    def get_raw_tables(db)
      sql = "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;"
      res = db.execute(sql).flatten
      mylog "sqlite", :res => res, :sql => sql
      res
    end
    fattr(:raw_tables) { get_raw_tables(db) }
    fattr(:tables) do
      raw_tables.reject { |x| x =~ /^(schema|sqlite)/ }
    end
    fattr(:parsers) do
      tables.map { |x| TableParser.new(:db => db, :table => x) }
    end
    def required_fields
      []
    end
    class TableParser < LineParser
      attr_accessor :db, :table
      include FromHash
      fattr(:execute_result) { db.execute2("SELECT * FROM #{table}") }
      fattr(:columns) { execute_result.first }
      fattr(:raw_rows) { execute_result[1..-1] }
      fattr(:value_hashes) do
        raw_rows.map do |row|
          Hash.from_keys_and_values(columns,row)
        end
      end
    end
  end
end