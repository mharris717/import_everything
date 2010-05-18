require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "ImportEverything" do
  describe Preview do
    describe 'csv' do
      before do
        @preview = Preview.new(:filename => spec_file('players.csv'), :table => 'players')
      end
      it 'ready' do
        @preview.should be_ready
      end
      it 'values' do
        table = @preview.preview_table
        table.row_value_arrays.first.should == ['Albert','Pujols',29]
        table.row_value_arrays.should size(3)
      end
      it 'keys' do
        @preview.preview_table.keys.should == ['first','last','age']
      end
    end
    
    describe 'xml' do
      before do
        @preview = Preview.new(:filename => spec_file('players.xml'))
        #@preview.table_paths = nil
      end
      it 'should need fields' do
        @preview.addl_required_fields.should == [:root_path,:table_paths]
      end
      it 'can set needed fields' do
        @preview.root_path = 'abc'
        @preview.addl_required_fields.should == [:table_paths]
      end
      describe 'ready' do
        before do
          @preview.root_path = 'top'
          @preview.table_paths = [['players','player']]
        end
        it 'ready' do
          @preview.should be_ready
        end
        it 'values' do
          @preview.table.row_value_arrays.first.should == ['Albert','Pujols',29]
        end
      end
    end
  end
  
end
