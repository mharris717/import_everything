module ImportEverything
  class CsvParser < Parser
    fattr(:delimiter) { "," }
    
    # Generates the value hashes
    def value_hashes
      require 'csv'
      res = []
      CSV.parse(str, :headers => true, :col_sep => delimiter) do |row|
        res << row.to_hash
      end
      res
    end
    def required_fields
      []
    end
  end
end