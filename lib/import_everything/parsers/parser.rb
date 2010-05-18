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
    fattr(:filename) { ImportEverything::DetermineType.get_filename(file) }
    fattr(:file) { open(filename) }
    fattr(:str) { file.read }
    
    def each_row
      each_table_and_rows do |table,rows|
        rows.each { |row| yield(table,row) }
      end
    end
    def each_table_and_rows
      cleaned_row_hashes.group_by { |x| x[:table] }.each do |table,rows|
        values = rows.map { |x| x[:values] }
        yield(table,values)
      end
    end
    def table_rows_hash
      res = {}
      each_table_and_rows { |table,rows| res[table] = rows }
      res
    end
  end
  module ParserPreviewMod
    fattr(:addl_required_fields) do
      required_fields.select do |x| 
        send(x).to_s.blank? 
      end
    end
    fattr(:required_fields) { [] }
  end
  Parser.send(:include,ParserPreviewMod)
end