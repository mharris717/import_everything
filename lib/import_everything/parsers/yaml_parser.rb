module ImportEverything
  class YamlParser < Parser
    
    def value_hashes
      require 'yaml'
      parsed = YAML::load(str)
      parsed.map do |root_val,row|
        row.merge("root" => root_val)
      end
    end 
  end
end