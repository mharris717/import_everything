module ImportEverything
  class DisplayTable
    attr_accessor :rows
    include FromHash
    fattr(:keys) do
      rows.map { |x| x.keys }.flatten.uniq
    end
    def each_row_value_array
      rows.each do |row|
        vals = keys.map { |k| row[k] }
        vals.each { |x| yield(x) }
      end
    end
    def row_value_arrays
      rows.map do |row|
        keys.map { |k| row[k] }
      end
    end
  end
  class Preview
    attr_accessor :ops
    def initialize(ops)
      self.ops = ops
    end
    fattr(:dt) { DetermineType.new(ops) }
    def parser
      dt.parser
    end
    def addl_required_fields
      parser.addl_required_fields
    end
    def ready?
      addl_required_fields.empty?
    end
    def preview_table
      DisplayTable.new(:rows => parser.cleaned_value_hashes)
    end
    def table; preview_table; end
    def method_missing(sym,*args,&b)
      if sym.to_s[-1..-1] == '='
        self.ops[sym.to_s[0..-2]] = args.first
        dt!
      else
        super
      end
    end
  end
end