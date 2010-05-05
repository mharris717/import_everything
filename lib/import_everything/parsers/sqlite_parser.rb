gem 'sqlite3-ruby'
require 'sqlite3'

class SqliteParser < Parser
  attr_accessor :filename
  include FromHash
  fattr(:db) { SQLite3::Database.new(filename) }
  fattr(:raw_tables) do
    sql = "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;"
    db.execute(sql).flatten
  end
  fattr(:tables) do
    raw_tables.reject { |x| x =~ /^(schema|sqlite)/ }
  end
  fattr(:parsers) do
    tables.map { |x| TableParser.new(:db => db, :table => x) }
  end
  class TableParser < ::LineParser
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

