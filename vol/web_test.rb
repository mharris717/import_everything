require 'json'
require 'pp'
require 'net/http'
load "lib/import_everything.rb"

csv = "a,b,c
1,2,3
4,5,6"

def get_parsed(body,filename=nil)
  uri = URI('http://importeverything.herokuapp.com/get')
  params = { :body => body, :filename => filename }
  uri.query = URI.encode_www_form(params)

  res = Net::HTTP.get_response(uri)
  rows = JSON.parse(res.body)
end


rows = get_parsed csv
puts rows.class
pp rows

sql = "insert into widgets (color,price) values ('Black',10);
insert into players (name,hr) values ('Babe',755);"
#sql = File.read("spec/players.sql")

rows = get_parsed sql, "widgets.sql"
pp rows

if false
  

  parser = ImportEverything::SqlInsertParser::LineParser.new(:line => sql)
  puts parser.value_hash.inspect

  parser = ImportEverything::SqlInsertParser.new(:str => sql, :filename => "abc.sql", :file => nil)
  puts parser.value_hashes.inspect
end