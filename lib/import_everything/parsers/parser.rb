class Hash
  def cleaned_hash_values
    map_value { |v| v.fixed_obj }
  end
end

class Parser
  fattr(:cleaned_value_hashes) do
    value_hashes.map { |row| row.cleaned_hash_values }
  end
  fattr(:cleaned_row_hashes) do
    row_hashes.map do |row_hash|
      {:table => row_hash[:table], :values => row_hash[:values].cleaned_hash_values}
    end
  end
  
  fattr(:value_hashes) do
    line_parsers.map { |x| x.value_hashes }.flatten
  end
  fattr(:row_hashes) do
    line_parsers.map { |x| x.row_hashes }.flatten
  end
  def line_parsers; parsers; end
  def parsers; line_parsers; end
end