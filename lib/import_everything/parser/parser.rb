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
 
    fattr(:row_hashes) do
      value_hashes.map { |x| {:table => table, :values => x} }
    end
    
    def value_hashes
      raise NotImplementedError.new("value_hashes in #{self.class}")
    end
    
    include DetermineType::Include

    fattr(:str) { file.read }
  end
  module ParserPreviewMod
    fattr(:addl_required_fields) do
      required_fields.select do |x| 
        send(x).to_s.blank? 
      end
    end
    fattr(:required_fields) { [] }
  end
  module IterationHelpers
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
  Parser.send(:include,ParserPreviewMod)
  Parser.send(:include,IterationHelpers)
  
  class Parser
    class ImpParsers < Parser
      # subclass must implement parsers or value_hashes
      # if implemented, should return an array of line parsers
      def parsers
        raise NotImplementedError.new("parsers")
      end
      def line_parsers; parsers; end
      fattr(:value_hashes) do
        parsers.map { |x| x.value_hashes }.flatten
      end
      fattr(:row_hashes) do
        parsers.map { |x| x.row_hashes }.flatten
      end
    end
  end
end