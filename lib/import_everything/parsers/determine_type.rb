module ImportEverything
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
end