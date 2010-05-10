require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "ImportEverything" do
  describe CsvParser do
    describe 'players' do
      before do
        @parser = CsvParser.new(:filename => spec_file('players.csv'), :table => 'players')
      end
      it 'smoke' do
        2.should == 2
      end
      it 'row count' do
        @parser.value_hashes.should size(3)
        @parser.cleaned_row_hashes.should size(3)
      end
      it 'cleaned hash' do
        @parser.cleaned_row_hashes.first.should == pujols_row_hash
        # @parser.cleaned_row_hashes.last.should == {:table => 'cities', :values => {'name' => 'Madison'}}
      end
    end
    
    describe 'howard' do
      before do
        @parser = TableParser.new(:filename => spec_file('howard.html'), :table => 'howard')
      end
      it 'row count' do
        @parser.value_hashes.should size(6)
      end
      it 'value hash' do
        @parser.cleaned_value_hashes[1]['PTS'].should == 15.8
      end
    end
  end
  
end
