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
    def method_missing(sym,*args,&b)
      if sym.to_s[-1..-1] == '='
        self.addl_ops[sym.to_s[0..-2]] = args.first
      else
        super
      end
    end
    fattr(:addl_ops) { {} }
    fattr(:parser_ops) { {:file => file}.merge(addl_ops) }
    def parser_class
      h = {'sqlite' => SqliteParser, 'sqlite3' => SqliteParser, 'csv' => CsvParser, 'xml' => XmlParser, 'sql' => SqlInsertParser, 'dmp' => SqlInsertParser, 'html' => TableParser}
      h[ext] || (raise "no parser found for #{ext}")
    end
    def parser
#      puts "parser ops is #{parser_ops.inspect}"
      parser_class.new(parser_ops)
    end
  end
end