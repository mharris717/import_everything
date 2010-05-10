module ImportEverything
  class XmlParser < Parser
    attr_accessor :root_path, :table_paths
    fattr(:table_paths) { [['players','player'],['cities','city']] }
    fattr(:root_path) { 'top' }
    fattr(:raw_doc) { require 'hpricot'; Hpricot(str) }
    fattr(:doc) { raw_doc/root_path }
    fattr(:parsers) do
      table_paths.map do |table_desc|
        docs = (doc/table_desc[0])
        TableParser.new(:table => table_desc[0], :doc => docs, :row_path => table_desc[1])
      end
    end
  
    class TableParser < Parser
      attr_accessor :doc, :table, :row_path
      include FromHash
      def row_docs
        doc/row_path
      end
      def parsers
        row_docs.map { |doc| LineParser.new(:doc => doc, :table => table) }
      end
    end
  
    class LineParser < LineParser
      attr_accessor :doc, :table
      include FromHash
      def value_hash
        cs = doc.children.reject { |x| x.to_s.blank? }
        cs.inject({}) { |h,el| h.merge(el.name => el.inner_text) }
      end
    end
  end
end