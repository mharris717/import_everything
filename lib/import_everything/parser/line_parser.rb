module ImportEverything
  class LineParser
    def value_hashes
      [value_hash]
    end
    fattr(:cleaned_value_hashes) do
      value_hashes.map { |row| row.cleaned_hash_values }
    end
    def row_hashes
      value_hashes.map { |x| {:table => table, :values => x} }
    end
  end
end