module ImportEverything
  class TableParser < CsvParser
    fattr(:delimiter) { "\t" }
  end
end