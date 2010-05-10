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
  class DetermineType
    include FromHash
    def self.get_filename(file)
      if file.kind_of?(String)
        ''
      else
        file.first_responding(:original_filename, :filename, :path)
      end
    end
    fattr(:filename) { self.class.get_filename(file) }
    fattr(:file) { open(filename) }
    fattr(:ext) { filename.split(".").last.downcase }
    def parser_class
      h = {'sqlite' => SqliteParser, 'sqlite3' => SqliteParser, 'csv' => CsvParser, 'xml' => XmlParser, 'sql' => SqlInsertParser, 'dmp' => SqlInsertParser, 'html' => TableParser}
      h[ext] || (raise "no parser found for #{ext}")
    end
    def parser
      parser_class.new(:file => file)
    end
  end
  def self.get_parser(ops)
    dt = DetermineType.new(ops)
    dt.parser
  end
  def self.get_rows(ops)
    get_parser(ops).cleaned_row_hashes
  end
  def self.each_row(ops)
    get_rows(ops).group_by { |x| x[:table] }.each do |table,rows|
      rows.each { |row| yield(table,row[:values]) }
    end
  end
end