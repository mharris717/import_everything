module ImportEverything
  class CsvParser < Parser
    fattr(:delimiter) { "," }
    def value_hashes
      require 'csv'
      res = []
      CSV.parse(str, :headers => true, :col_sep => delimiter) do |row|
        res << row.to_hash
      end
      res
    end
  end
end