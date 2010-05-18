module ImportEverything
  def self.get_parser(ops)
    dt = ImportEverything::DetermineType.new(ops)
    dt.parser
  end
  def self.get_rows(ops)
    get_parser(ops).cleaned_row_hashes
  end
  def self.each_row(ops,&b)
    get_parser(ops).each_row(&b)
  end
  def self.each_table_and_rows(ops,&b)
    get_parser(ops).each_table_and_rows(&b)
  end
  def self.preview(ops)
    Preview.new(ops)
  end
end