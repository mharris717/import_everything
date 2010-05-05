require 'rubygems'
require 'mharris_ext'

this_path = File.expand_path(File.dirname(__FILE__))
Dir["#{this_path}/import_everything/**/*.rb"].each { |x| require x }