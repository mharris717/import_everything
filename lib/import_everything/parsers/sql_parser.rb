class String
  def blank?
    strip == ''
  end
  def present?
    !blank?
  end
end

module MethodLogging
  def log_method(name)
    alias_method "unlogged_#{name}", name
    define_method(name) do |*args|
      res = send("unlogged_#{name}",*args)
      puts "#{name} returned #{res.inspect} from #{args.inspect}"
      res
    end
  end
  def def_logging_method(name,&b)
    define_method(name) do |*args|
      res = instance_eval()
    end
  end
end

class Hash
  def self.from_keys_and_values(ks,vs)
    raise "size not equal #{ks.size} #{vs.size}" unless ks.size == vs.size
    ks.zip(vs).inject({}) { |h,a| h.merge(a[0] => a[1]) }
  end
end

class String
  def without_quotes
    if self =~ /^['"].*['"]$/
      self[1..-2]
    else
      self
    end
  end
end

class SqlInsertParser
  attr_accessor :str
  include FromHash
  fattr(:lines) do
    str.split(/\n|;/).map { |x| x.strip }.select { |x| x.present? }
  end
  fattr(:probable_insert_lines) do
    lines.select { |x| LineParser.probable_insert?(x) }
  end
  def get_insert_lines(lines)
    if lines.empty?
      []
    elsif LineParser.comment?(lines.first)
      get_insert_lines(lines[1..-1])
    elsif LineParser.valid_insert?(lines.first)
      [lines.first] + get_insert_lines(lines[1..-1])
    elsif lines.size >= 2 && LineParser.valid_insert?(lines[0..1].join(" "))
      [lines[0..1].join(" ")] + get_insert_lines(lines[2..-1])
    elsif lines.size >= 3 && LineParser.valid_insert?(lines[0..2].join(" "))
      [lines[0..2].join(" ")] + get_insert_lines(lines[2..-1])
    else
      get_insert_lines(lines[1..-1])
    end
  end
  fattr(:insert_lines) do
    get_insert_lines(lines)
  end
  fattr(:line_parsers) do
    insert_lines.map { |ln| LineParser.new(:line => ln) }
  end
  fattr(:value_hashes) do
    line_parsers.map { |x| x.value_hash }
  end
  fattr(:row_hashes) do
    line_parsers.map { |x| x.row_hash }
  end
  class LineParser
    attr_accessor :line
    include FromHash
    extend MethodLogging
    class << self
      fattr(:insert_into_regex) { /INSERT\s+INTO\s+(\S+)/i }
      fattr(:columns_regex) { /\((.*)\)/i }
      fattr(:values_regex) { /VALUES\s+\((.*)\)/i }
      fattr(:full_regex) { /^\s*#{insert_into_regex}\s+#{columns_regex}\s+#{values_regex}/i }
      fattr(:regex_hash) do
        {:insert => insert_into_regex, :columns => columns_regex, :values => values_regex, :full => full_regex}
      end
      fattr(:comment_regex) do
        /^(\/\*|#)/
      end
      def probable_insert?(str)
        str = str.strip
        res = (str =~ insert_into_regex) && !comment?(str)
        !!res
      end
      def valid_insert?(str)
        !!(str =~ full_regex)
      end
      def comment?(str)
        !!(str =~ comment_regex)
      end
    end
    fattr(:parsed_elements) do
      raise "doesn't parse" unless line =~ self.class.full_regex
      {:table => $1, :columns => $2, :values => $3}
    end
    fattr(:table) { parsed_elements[:table].without_quotes }
    fattr(:columns) do
      parsed_elements[:columns].split(",").map { |x| x.downcase.strip.without_quotes }
    end
    def fix_value(v)
      v = v.strip.without_quotes
      if v =~ /^\d+$/
        v.to_i
      else
        v
      end
    end
    #log_method :fix_value
    fattr(:values) do
      require 'csv'
      raw = parsed_elements[:values]
      CSV.parse(raw).first.map { |x| fix_value(x) }
    end
    fattr(:value_hash) do
      Hash.from_keys_and_values(columns,values)
    end
    fattr(:row_hash) do
      {:table => table, :values => value_hash}
    end
  end
end



