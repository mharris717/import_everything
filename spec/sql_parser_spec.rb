require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "ImportEverything" do
  describe SqlInsertParser do
    before do
      @pujols_value_hash = pujols_value_hash
    end
    describe SqlInsertParser::LineParser do
      before do
        @sql = "INSERT into players (first ,LAST,age) VALUES (\"Albert\", 'Pujols',29)"
      end
      fattr(:parser) do
        SqlInsertParser::LineParser.new(:line => @sql)
      end
      SqlInsertParser::LineParser.regex_hash.each do |name,reg|
        mit "can match against #{name} regex" do
          (@sql =~ reg).should be
        end
      end
      mit 'parses table name' do
        parser.table.should == 'players'
      end
      mit 'parses raw columns' do
        parser.parsed_elements[:columns].should == 'first ,LAST,age'
      end
      mit 'parses raw values' do
        parser.parsed_elements[:values].should == "\"Albert\", 'Pujols',29"
      end
      mit 'parses columns' do
        parser.columns.should == %w(first last age)
      end
      mit 'parses values' do
        parser.values.should == ['Albert','Pujols',29]
      end
      mit 'value hash' do
        parser.value_hash.should == @pujols_value_hash
      end
      mit 'quote regex match' do
        ('"abc"' =~ /^['"].*['"]$/).should be
        '"abc"'.should =~ /^['"].*['"]$/
        "'abc'".should =~ /^['"].*['"]$/
      end
      it "ignore commented lines" do
        line = "# INSERT INTO players (a,b,c) VALUES (d,e,f)"
        SqlInsertParser::LineParser.should_not be_probable_insert(line)
      end
      it 'can handle quoted table' do
        @sql = "INSERT into 'players' (first ,LAST,'age') VALUES (\"Albert\", 'Pujols',29)"
        parser.table.should == 'players'
      end
      it 'can handle quoted column' do
        @sql = "INSERT into players (first ,LAST,'age') VALUES (\"Albert\", 'Pujols',29)"
        parser.columns.should == %w(first last age)
      end
      it 'can handle multi line insert' do
        @sql = "INSERT into players (first,last,age) 
                VALUES (\"Albert\", 'Pujols',29)"
        parser.values.should == ['Albert','Pujols',29]
        parser.value_hash.should == @pujols_value_hash
      end
    end
    
    describe 'file parsing' do
      before do
        @lines = ["select * from foo","CREATE TABLE PLAYERS (","insert stuff",")"]
        @lines << "#INSERT into players (first,last,age) VALUES (\"Hanley\", 'Ramirez',27);    \n    "
        @lines << "INSERT into players (first,last,age) VALUES (\"Albert\", 'Pujols',29)\n"
        @lines << "INSERT into players (first,last,age) VALUES (\"Hanley\", 'Ramirez',27);    \n    "
        @lines << "INSERT into players (first,last,age) VALUES (\"David\", 'Wright',26);       "
      end
      fattr(:sql) { @lines.join("\n") }
      fattr(:parser) { SqlInsertParser.new(:str => sql) }
      it 'has right number of lines' do
        parser.lines.size.should == @lines.size
      end
      it 'has 3 probable lines' do
        parser.probable_insert_lines.size.should == 3
      end
      it 'value hashes' do
        #raise parser.insert_lines.inspect
        parser.value_hashes.size.should == 3
        parser.value_hashes.first.should == @pujols_value_hash
        parser.value_hashes[1].should == {'first' => 'Hanley', 'last' => 'Ramirez', 'age' => 27}
      end
      it 'row hashes' do
        parser.row_hashes.first.should == pujols_row_hash
      end
      describe 'multi line insert' do
        before do
          @lines[-3] = @lines[-3].gsub(/VALUES/,"\nVALUES").gsub(/players /,"players\n")
        end
        it 'right number of insert lines' do
          parser.insert_lines.should size(3)
        end
        it 'right value hash' do
          parser.value_hashes.first.should == @pujols_value_hash
        end
      end
    end
  end
  
end
