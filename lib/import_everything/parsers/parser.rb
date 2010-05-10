module ImportEverything
  class Parser
    fattr(:table) { 'some_table' }
    include FromHash
    fattr(:cleaned_value_hashes) do
      value_hashes.map { |row| row.cleaned_hash_values }
    end
    fattr(:cleaned_row_hashes) do
      row_hashes.map do |row_hash|
        {:table => row_hash[:table], :values => row_hash[:values].cleaned_hash_values}
      end
    end
  
    fattr(:value_hashes) do
      parsers.map { |x| x.value_hashes }.flatten
    end
    fattr(:row_hashes) do
      if respond_to?(:parsers)
        parsers.map { |x| x.row_hashes }.flatten
      else
        value_hashes.map { |x| {:table => table, :values => x} }
      end
    end
    def line_parsers; parsers; end
    fattr(:filename) { DetermineType.get_filename(file) }
    fattr(:file) { open(filename) }
    fattr(:str) { file.read }
  end
end