module ImportEverything
  class DetermineType
    include FromHash
    def self.get_filename(file)
      if file.kind_of?(String)
        ''
      else
        file.first_responding(:original_filename, :filename, :path, :name)
      end
    end
    
    
    fattr(:filename) { self.class.get_filename(file) }
    fattr(:file) { open(filename) }
    
    # Get the file extension
    # @return [String] file extension
    fattr(:ext) { filename.split(".").last.downcase }
    
    def method_missing(sym,*args,&b)
      if sym.to_s[-1..-1] == '='
        self.addl_ops[sym.to_s[0..-2]] = args.first
      else
        super
      end
    end
    
    # Store addl ops
    fattr(:addl_ops) { {} }
    fattr(:parser_ops) { {:file => file}.merge(addl_ops) }
    
    # Determines what parser class should be used for this file
    def parser_class
      h = {'sqlite' => SqliteParser, 'sqlite3' => SqliteParser, 'csv' => CsvParser, 'xml' => XmlParser, 'sql' => SqlInsertParser, 'dmp' => SqlInsertParser, 'html' => TableParser}
      h = h.merge('yaml' => YamlParser, 'yml' => 'YamlParser')
      h[ext].tap { |x| return x if x }
      h.each do |k,klass|
        return klass if ext =~ /^#{k}\d\d/
      end
      raise "no parser found for #{ext}"
    end
    
    # Creates the parser
    def parser
      parser_class.new(parser_ops)
    end
    
    module Include
      fattr(:dt) do
        DetermineType.new
      end

      %w(filename file).each do |m|
        define_method(m) { dt.send(m) }
        define_method("#{m}=") { |v| dt.send("#{m}=",v) }
      end
    end
  end
end