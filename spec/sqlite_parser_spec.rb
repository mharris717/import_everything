require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

load "spec/helpers/test_db.rb"

# raise TestDB.instance.db.execute2("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;").flatten.inspect

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
