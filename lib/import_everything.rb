require 'rubygems'
require 'mharris_ext'
require 'active_support'

this_path = File.expand_path(File.dirname(__FILE__))
require "#{this_path}/import_everything/ext"
paths = Dir["#{this_path}/import_everything/**/*.rb"]
paths = paths.make_first { |path| %w(determine_type.rb parser.rb line_parser.rb).include?(File.basename(path)) }
paths.each { |x| require x }

