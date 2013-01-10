require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "ImportEverything" do
  describe XmlParser do
    before do
      @parser = XmlParser.new(:filename => spec_file("players.xml"), :root_path => 'top', :table_paths => [['players','player'],['cities','city']])
      #@parser.table_paths = nil
    end
    it 'smoke' do
      2.should == 2
    end
    it 'parsers' do
      @parser.parsers
    end
    it 'row count' do
      @parser.value_hashes.should size(4)
      @parser.cleaned_row_hashes.should size(4)
    end
    it 'first doc' do
      @parser.parsers.first.cleaned_value_hashes.first.should == pujols_value_hash
    end
    it 'hashes' do
      @parser.parsers.first.cleaned_value_hashes
    end
    it 'city' do
      @parser.cleaned_row_hashes.first.should == pujols_row_hash
      @parser.cleaned_row_hashes.last.should == {:table => 'cities', :values => {'name' => 'Madison'}}
    end
  end
  
end
