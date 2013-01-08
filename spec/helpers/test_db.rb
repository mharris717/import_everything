class TestDB
  class << self
    fattr(:instance) { new }
  end
  fattr(:filename) { "/Code/wheeeee.sqlite3" }
  fattr(:db_inner) do
    require 'sqlite3'
    SQLite3::Database.new(filename) 
    #SQLite3::Database.new(open("http://localhost:3000/wheeeee.sqlite3") { |f| f.read })
  end
  fattr(:create) do
    `rm -f #{filename}` 
    db = db_inner
    db.execute("CREATE TABLE cities ( name varchar(255) )")
    db.execute("CREATE TABLE players ( first varchar(255), last varchar(255), age integer)")
    #raise db.execute("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;").inspect
    db.execute("INSERT into players (first,last,age) VALUES ('Albert','Pujols',29)")
    db.execute("INSERT into players (first,last,age) VALUES ('David','Wright',26)")
    db.execute("INSERT into players (first,last,age) VALUES ('Hanley','Ramirez',27)")
    db.execute("INSERT into cities (name) VALUES ('Madison')")
    raise "foo" unless db.execute("select count(*) from players").flatten.first.to_i == 3
  end
  fattr(:db) do
    create
    db_inner
  end
  #def create; end
end
def create_test_db!
  
end