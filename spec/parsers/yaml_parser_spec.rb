require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "ImportEverything" do
  describe YamlParser do
    let(:parser) do
      YamlParser.new(:filename => spec_file('database.yml'), :table => 'database')
    end
    it 'size' do
      parser.value_hashes.should size(3)
    end
    it 'first root' do
      parser.value_hashes[0]["root"].should == 'development'
    end
  end
end