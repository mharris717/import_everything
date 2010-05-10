require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class TestDB
  class << self
    fattr(:instance) { new }
  end
  fattr(:filename) { "/Code/wheeeee.sqlite3" }
  fattr(:db) do
    gem 'sqlite3-ruby'
    require 'sqlite3'
    SQLite3::Database.new(filename) 
  end
  fattr(:create) do
    `rm -f #{filename}`
    db.execute("CREATE TABLE cities ( name varchar(255) )")
    db.execute("CREATE TABLE players ( first varchar(255), last varchar(255), age integer)")
    #raise db.execute("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;").inspect
    db.execute("INSERT into players (first,last,age) VALUES ('Albert','Pujols',29)")
    db.execute("INSERT into players (first,last,age) VALUES ('David','Wright',26)")
    db.execute("INSERT into players (first,last,age) VALUES ('Hanley','Ramirez',27)")
    db.execute("INSERT into cities (name) VALUES ('Madison')")
    raise "foo" unless db.execute("select count(*) from players").flatten.first.to_i == 3
  end
end
def create_test_db!
  
end

describe "ImportEverything" do
  describe SqliteParser do
    before do
      TestDB.instance.create
      #@parser = SqliteParser.new(:filename => TestDB.instance.filename)
      @parser = ImportEverything.get_parser(:filename => TestDB.instance.filename)
      @rows = ImportEverything.get_rows(:filename => TestDB.instance.filename)
    end
    it 'tables' do
      @parser.tables.should == ['cities','players']
    end
    it 'value hashes' do
      @parser.cleaned_value_hashes.size.should == 4
      @parser.cleaned_value_hashes[1].should == pujols_value_hash
    end
    it 'row hashes' do
      @parser.cleaned_row_hashes.first.should == {:table => 'cities', :values => {'name' => 'Madison'}}
      @parser.cleaned_row_hashes[1].should == pujols_row_hash
      @rows.first.should == {:table => 'cities', :values => {'name' => 'Madison'}}
      @rows[1].should == pujols_row_hash
    end
  end
  
end
