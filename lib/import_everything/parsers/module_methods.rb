module ImportEverything
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